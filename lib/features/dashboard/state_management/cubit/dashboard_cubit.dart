import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_gamification_platform/core/gamification/level_calculator.dart';
import 'package:stack_gamification_platform/core/gamification/skill_catalog.dart';
import 'package:stack_gamification_platform/core/gamification/skill_id.dart';
import 'package:stack_gamification_platform/core/gamification/skill_questions.dart';
import 'package:stack_gamification_platform/features/authentication/domain/repository/auth_repository.dart';
import 'package:stack_gamification_platform/features/skills/domain/model/skill_rating.dart';
import 'package:stack_gamification_platform/features/skills/domain/repository/skill_repository.dart';
import 'package:stack_gamification_platform/features/user/domain/model/app_user.dart';
import 'package:stack_gamification_platform/features/user/domain/repository/user_repository.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final UserRepository _userRepository;
  final SkillRepository _skillRepository;
  final String _uid;
  StreamSubscription<AppUser?>? _userSubscription;
  StreamSubscription<List<SkillRating>>? _skillsSubscription;

  DashboardCubit(
    this._userRepository,
    this._skillRepository,
    AuthRepository authRepository,
  ) : _uid = authRepository.currentUserId ?? '',
      super(const DashboardState()) {
    _userSubscription = _userRepository.watchUser(_uid).listen((user) {
      emit(state.copyWith(user: user, isLoading: false));
    });
    _skillsSubscription = _skillRepository.watchSkills(_uid).listen((skills) {
      emit(state.copyWith(ratedSkills: skills));
    });
  }

  /// The user's catalog skills merged with their saved ratings (defaulting
  /// unrated catalog skills to 0), followed by any custom skills they added.
  List<SkillRating> get displaySkills => _mergeSkills(state.ratedSkills);

  List<SkillRating> _mergeSkills(List<SkillRating> ratedSkills) {
    final stack = state.user?.stack;
    final catalog = stack != null
        ? SkillCatalog.skillsFor(stack)
        : const <String>[];
    final byId = {for (final s in ratedSkills) s.skillId: s};
    final result = <SkillRating>[];
    for (final name in catalog) {
      final id = SkillId.fromName(name);
      result.add(byId[id] ?? SkillRating(skillId: id, name: name, rating: 0));
    }
    final catalogIds = catalog.map(SkillId.fromName).toSet();
    for (final s in ratedSkills) {
      if (!catalogIds.contains(s.skillId)) result.add(s);
    }
    return result;
  }

  Future<void> assessSkill({
    required String skillId,
    required String name,
    required Map<String, SkillAnswer> answers,
    required int projectsCount,
  }) async {
    await _skillRepository.upsertAssessment(
      uid: _uid,
      skillId: skillId,
      name: name,
      answers: answers,
      projectsCount: projectsCount,
    );
    final rating = SkillAssessment.computeRating(
      answers: answers,
      projectsCount: projectsCount,
    );
    final merged = {for (final s in displaySkills) s.skillId: s};
    merged[skillId] = SkillRating(
      skillId: skillId,
      name: name,
      rating: rating,
      answers: answers,
      projectsCount: projectsCount,
    );
    final totalXp = LevelCalculator.totalXp(merged.values.map((s) => s.rating));
    await _userRepository.updateAggregateXp(uid: _uid, totalXp: totalXp);
  }

  Future<void> addCustomSkill({
    required String name,
    required Map<String, SkillAnswer> answers,
    required int projectsCount,
  }) {
    return assessSkill(
      skillId: SkillId.fromName(name),
      name: name,
      answers: answers,
      projectsCount: projectsCount,
    );
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    _skillsSubscription?.cancel();
    return super.close();
  }
}
