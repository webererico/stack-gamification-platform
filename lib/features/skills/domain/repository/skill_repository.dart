import 'package:stack_gamification_platform/features/skills/domain/model/skill_rating.dart';

abstract interface class SkillRepository {
  Stream<List<SkillRating>> watchSkills(String uid);

  Future<void> upsertRating({
    required String uid,
    required String skillId,
    required String name,
    required int rating,
  });
}
