import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/gamification/level_calculator.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';

/// Small pill showing a developer's overall level, e.g. "🚀 Sênior".
class LevelBadge extends StatelessWidget {
  const LevelBadge({required this.level, this.compact = false, super.key});

  final DevLevel level;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 12,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(level.emoji, style: TextStyle(fontSize: compact ? 12 : 14)),
          const SizedBox(width: 4),
          Text(
            level.label,
            style: (compact ? AppStyle.subtitle12 : AppStyle.title14).copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Small chip showing a skill's tier, e.g. "Avançado".
class SkillTierChip extends StatelessWidget {
  const SkillTierChip({required this.tier, super.key});

  final SkillTier tier;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: tier.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        tier.label,
        style: AppStyle.subtitle10.copyWith(
          color: tier.color,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
