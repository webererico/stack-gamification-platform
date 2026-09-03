import 'package:stack_gamification_platform/core/gamification/skill_questions.dart';
import 'package:stack_gamification_platform/features/skills/domain/model/skill_rating.dart';

abstract interface class SkillRepository {
  Stream<List<SkillRating>> watchSkills(String uid);

  Future<void> upsertAssessment({
    required String uid,
    required String skillId,
    required String name,
    required Map<String, SkillAnswer> answers,
    required int projectsCount,
  });
}
