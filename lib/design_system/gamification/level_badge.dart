import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/gamification/level_calculator.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';

/// Small pill showing a developer's overall level, e.g. a colored rank dot
/// next to "Sênior" — no emoji, matching the dev-tool visual language.
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
        color: level.color.withValues(alpha: 0.12),
        border: Border.all(color: level.color.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: compact ? 6 : 7,
            height: compact ? 6 : 7,
            decoration: BoxDecoration(
              color: level.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            level.label,
            style: (compact ? AppStyle.subtitle12 : AppStyle.title14).copyWith(
              color: level.color,
              fontWeight: FontWeight.w600,
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
        color: tier.color.withValues(alpha: 0.12),
        border: Border.all(color: tier.color.withValues(alpha: 0.35)),
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
