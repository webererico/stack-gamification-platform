import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/gamification/level_calculator.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/gamification/level_badge.dart';
import 'package:stack_gamification_platform/design_system/gamification/user_avatar.dart';

/// Header card showing total XP, current level and progress to the next
/// level. Used on the dashboard and profile screens.
class XpSummaryCard extends StatelessWidget {
  const XpSummaryCard({
    required this.name,
    required this.totalXp,
    this.subtitle,
    this.photoUrl,
    super.key,
  });

  final String name;
  final int totalXp;
  final String? subtitle;
  final String? photoUrl;

  @override
  Widget build(BuildContext context) {
    final level = LevelCalculator.levelForXp(totalXp);
    final progress = LevelCalculator.progressToNextLevel(totalXp);
    final xpToNext = LevelCalculator.xpToNextLevel(totalXp);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: AppBorder.radius16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              UserAvatar(name: name, photoUrl: photoUrl, radius: 20),
              AppSpaces.horizontal12,
              Expanded(
                child: Text(
                  name,
                  style: AppStyle.heading20,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              LevelBadge(level: level),
            ],
          ),
          if (subtitle != null) ...[
            AppSpaces.vertical4,
            Text(subtitle!, style: AppStyle.body14),
          ],
          AppSpaces.vertical24,
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('$totalXp', style: AppStyle.dataLarge),
              const SizedBox(width: 6),
              Text('XP', style: AppStyle.body14),
              const Spacer(),
              if (xpToNext != null)
                Text('$xpToNext p/ próximo nível', style: AppStyle.dataSmall)
              else
                Text('Nível máximo alcançado', style: AppStyle.dataSmall),
            ],
          ),
          AppSpaces.vertical8,
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) {
                return Stack(
                  children: [
                    Container(height: 6, color: AppColors.xpTrackColor),
                    FractionallySizedBox(
                      widthFactor: value,
                      child: Container(
                        height: 6,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
