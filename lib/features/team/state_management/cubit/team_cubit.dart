import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_gamification_platform/features/authentication/domain/repository/auth_repository.dart';
import 'package:stack_gamification_platform/features/user/domain/model/app_user.dart';
import 'package:stack_gamification_platform/features/user/domain/repository/user_repository.dart';
part 'team_state.dart';

class TeamCubit extends Cubit<TeamState> {
  final UserRepository _userRepository;
  final String _uid;
  StreamSubscription<AppUser?>? _userSubscription;
  StreamSubscription<List<AppUser>>? _membersSubscription;
  String? _lastSquadId;

  TeamCubit(this._userRepository, AuthRepository authRepository)
    : _uid = authRepository.currentUserId ?? '',
      super(const TeamState()) {
    _userSubscription = _userRepository.watchUser(_uid).listen((user) {
      emit(state.copyWith(squadName: user?.squadName, currentUid: _uid));
      final squadId = user?.squadId;
      if (squadId == _lastSquadId) return;
      _lastSquadId = squadId;
      _membersSubscription?.cancel();
      if (squadId == null) {
        emit(state.copyWith(members: const [], isLoading: false));
        return;
      }
      _membersSubscription = _userRepository.watchSquadMembers(squadId).listen((
        members,
      ) {
        emit(state.copyWith(members: members, isLoading: false));
      });
    });
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    _membersSubscription?.cancel();
    return super.close();
  }
}
