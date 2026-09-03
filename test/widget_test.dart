import 'package:flutter_test/flutter_test.dart';
import 'package:stack_gamification_platform/core/gamification/level_calculator.dart';

void main() {
  group('LevelCalculator', () {
    test('xpForRating converts a 0-10 rating into XP', () {
      expect(LevelCalculator.xpForRating(0), 0);
      expect(LevelCalculator.xpForRating(5), 500);
      expect(LevelCalculator.xpForRating(10), 1000);
    });

    test('totalXp sums XP across every rated skill', () {
      expect(LevelCalculator.totalXp([8, 7, 10]), 2500);
      expect(LevelCalculator.totalXp([]), 0);
    });

    test('levelForXp maps XP totals to the right tier', () {
      expect(LevelCalculator.levelForXp(0), DevLevel.iniciante);
      expect(LevelCalculator.levelForXp(499), DevLevel.iniciante);
      expect(LevelCalculator.levelForXp(500), DevLevel.aprendiz);
      expect(LevelCalculator.levelForXp(1500), DevLevel.pleno);
      expect(LevelCalculator.levelForXp(3000), DevLevel.senior);
      expect(LevelCalculator.levelForXp(5000), DevLevel.especialista);
    });

    test('progressToNextLevel is 1.0 once at the max level', () {
      expect(LevelCalculator.progressToNextLevel(5000), 1.0);
      expect(LevelCalculator.xpToNextLevel(5000), isNull);
    });
  });

  group('SkillTierX', () {
    test('fromRating buckets ratings into the right tier', () {
      expect(SkillTierX.fromRating(0), SkillTier.iniciante);
      expect(SkillTierX.fromRating(4), SkillTier.intermediario);
      expect(SkillTierX.fromRating(7), SkillTier.avancado);
      expect(SkillTierX.fromRating(9), SkillTier.expert);
      expect(SkillTierX.fromRating(10), SkillTier.expert);
    });
  });
}
