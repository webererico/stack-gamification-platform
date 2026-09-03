import 'package:flutter_test/flutter_test.dart';
import 'package:stack_gamification_platform/core/gamification/level_calculator.dart';
import 'package:stack_gamification_platform/core/gamification/skill_questions.dart';

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

  group('SkillAssessment.computeRating', () {
    test('scores 0 when every question is "não sei"', () {
      final answers = {
        for (final q in SkillAssessment.questions) q.id: SkillAnswer.unknown,
      };
      expect(
        SkillAssessment.computeRating(answers: answers, projectsCount: 0),
        0,
      );
    });

    test('"não" scores the same as "não sei": nothing', () {
      final answers = {
        for (final q in SkillAssessment.questions) q.id: SkillAnswer.no,
      };
      expect(
        SkillAssessment.computeRating(answers: answers, projectsCount: 10),
        2, // only the projects bonus point scores.
      );
    });

    test('reaching 10/10 requires every "sim" AND more than the threshold '
        'of projects', () {
      final allYes = {
        for (final q in SkillAssessment.questions) q.id: SkillAnswer.yes,
      };
      expect(
        SkillAssessment.computeRating(
          answers: allYes,
          projectsCount: SkillAssessment.projectsThreshold,
        ),
        8, // all yes, but not yet over the projects threshold.
      );
      expect(
        SkillAssessment.computeRating(
          answers: allYes,
          projectsCount: SkillAssessment.projectsThreshold + 1,
        ),
        10,
      );
    });
  });
}
