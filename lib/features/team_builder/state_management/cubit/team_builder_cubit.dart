import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_gamification_platform/design_system/gamification/team_palette.dart';
import 'package:stack_gamification_platform/features/authentication/domain/repository/auth_repository.dart';
import 'package:stack_gamification_platform/features/skills/domain/model/skill_rating.dart';
import 'package:stack_gamification_platform/features/skills/domain/repository/skill_repository.dart';
import 'package:stack_gamification_platform/features/user/domain/model/app_user.dart';
import 'package:stack_gamification_platform/features/user/domain/repository/user_repository.dart';
part 'team_builder_state.dart';

/// Backs "Monte seu Time": pick teammates from the squad and see their
/// skills overlaid — one radar per person, one color each — plus an XP
/// comparison, to eyeball whether a lineup is balanced for a project.
class TeamBuilderCubit extends Cubit<TeamBuilderState> {
  final UserRepository _userRepository;
  final SkillRepository _skillRepository;
  final String _uid;
  StreamSubscription<AppUser?>? _userSubscription;
  StreamSubscription<List<AppUser>>? _membersSubscription;
  final Map<String, StreamSubscription<List<SkillRating>>> _skillSubscriptions =
      {};
  String? _lastSquadId;

  TeamBuilderCubit(
    this._userRepository,
    this._skillRepository,
    AuthRepository authRepository,
  ) : _uid = authRepository.currentUserId ?? '',
      super(const TeamBuilderState()) {
    _userSubscription = _userRepository.watchUser(_uid).listen((user) {
      final squadId = user?.squadId;
      if (squadId == _lastSquadId) return;
      _lastSquadId = squadId;
      _membersSubscription?.cancel();
      if (squadId == null) {
        emit(state.copyWith(members: const [], isLoading: false));
        return;
      }
      _membersSubscription = _userRepository
          .watchSquadMembers(squadId)
          .listen(
            (members) =>
                emit(state.copyWith(members: members, isLoading: false)),
          );
    });
  }

  void toggleMember(String uid) {
    final selected = List<String>.from(state.selectedUids);
    if (selected.contains(uid)) {
      selected.remove(uid);
      _skillSubscriptions.remove(uid)?.cancel();
      final skillsByUid = Map<String, List<SkillRating>>.from(state.skillsByUid)
        ..remove(uid);
      emit(state.copyWith(selectedUids: selected, skillsByUid: skillsByUid));
      return;
    }
    if (selected.length >= kTeamBuilderMaxMembers) return;
    selected.add(uid);
    emit(state.copyWith(selectedUids: selected));
    _skillSubscriptions[uid] = _skillRepository.watchSkills(uid).listen((
      skills,
    ) {
      final skillsByUid = Map<String, List<SkillRating>>.from(
        state.skillsByUid,
      );
      skillsByUid[uid] = skills;
      emit(state.copyWith(skillsByUid: skillsByUid));
    });
  }

  void clearSelection() {
    for (final sub in _skillSubscriptions.values) {
      sub.cancel();
    }
    _skillSubscriptions.clear();
    emit(state.copyWith(selectedUids: const [], skillsByUid: const {}));
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    _membersSubscription?.cancel();
    for (final sub in _skillSubscriptions.values) {
      sub.cancel();
    }
    return super.close();
  }
}
