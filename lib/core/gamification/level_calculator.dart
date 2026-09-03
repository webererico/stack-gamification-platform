import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';

/// Pure gamification rules: how a 0-10 self-rating turns into XP, skill
/// tiers and an overall developer level. Kept framework-free so it can be
/// unit tested and reused by any feature (dashboard, team, profile).

enum SkillTier { iniciante, intermediario, avancado, expert }

extension SkillTierX on SkillTier {
  static SkillTier fromRating(int rating) {
    if (rating >= 9) return SkillTier.expert;
    if (rating >= 7) return SkillTier.avancado;
    if (rating >= 4) return SkillTier.intermediario;
    return SkillTier.iniciante;
  }

  String get label => switch (this) {
    SkillTier.iniciante => 'Iniciante',
    SkillTier.intermediario => 'Intermediário',
    SkillTier.avancado => 'Avançado',
    SkillTier.expert => 'Expert',
  };

  Color get color => switch (this) {
    SkillTier.iniciante => AppColors.tierIniciante,
    SkillTier.intermediario => AppColors.tierIntermediario,
    SkillTier.avancado => AppColors.tierAvancado,
    SkillTier.expert => AppColors.tierExpert,
  };
}

enum DevLevel { iniciante, aprendiz, pleno, senior, especialista }

extension DevLevelX on DevLevel {
  String get label => switch (this) {
    DevLevel.iniciante => 'Iniciante',
    DevLevel.aprendiz => 'Aprendiz',
    DevLevel.pleno => 'Pleno',
    DevLevel.senior => 'Sênior',
    DevLevel.especialista => 'Especialista',
  };

  Color get color => switch (this) {
    DevLevel.iniciante => AppColors.tierIniciante,
    DevLevel.aprendiz => AppColors.tierIniciante,
    DevLevel.pleno => AppColors.tierIntermediario,
    DevLevel.senior => AppColors.tierAvancado,
    DevLevel.especialista => AppColors.tierExpert,
  };
}

abstract class LevelCalculator {
  /// XP awarded for a single skill rating (0-10).
  static int xpForRating(int rating) => rating.clamp(0, 10) * 100;

  /// Total XP across every rated skill.
  static int totalXp(Iterable<int> ratings) =>
      ratings.fold(0, (sum, r) => sum + xpForRating(r));

  static const List<(DevLevel level, int minXp)> _thresholds = [
    (DevLevel.especialista, 5000),
    (DevLevel.senior, 3000),
    (DevLevel.pleno, 1500),
    (DevLevel.aprendiz, 500),
    (DevLevel.iniciante, 0),
  ];

  static DevLevel levelForXp(int xp) {
    for (final (level, minXp) in _thresholds) {
      if (xp >= minXp) return level;
    }
    return DevLevel.iniciante;
  }

  /// Progress (0.0-1.0) towards the next level, for progress bars.
  static double progressToNextLevel(int xp) {
    final level = levelForXp(xp);
    final index = _thresholds.indexWhere((t) => t.$1 == level);
    final isMax = index == 0;
    if (isMax) return 1;
    final currentMin = _thresholds[index].$2;
    final nextMin = _thresholds[index - 1].$2;
    final span = nextMin - currentMin;
    if (span <= 0) return 1;
    return ((xp - currentMin) / span).clamp(0, 1).toDouble();
  }

  static int? xpToNextLevel(int xp) {
    final level = levelForXp(xp);
    final index = _thresholds.indexWhere((t) => t.$1 == level);
    if (index == 0) return null;
    final nextMin = _thresholds[index - 1].$2;
    return nextMin - xp;
  }
}
