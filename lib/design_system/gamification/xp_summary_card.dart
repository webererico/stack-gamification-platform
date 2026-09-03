import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/gamification/level_calculator.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/gamification/level_badge.dart';

/// Header card showing total XP, current level and progress to the next
/// level. Used on the dashboard and profile screens.
class XpSummaryCard extends StatelessWidget {
  const XpSummaryCard({
    required this.name,
    required this.totalXp,
    this.subtitle,
    super.key,
  });

  final String name;
  final int totalXp;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final level = LevelCalculator.levelForXp(totalXp);
    final progress = LevelCalculator.progressToNextLevel(totalXp);
    final xpToNext = LevelCalculator.xpToNextLevel(totalXp);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryColor, Color(0xFF9B7CFF)],
        ),
        borderRadius: AppBorder.radius16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: AppStyle.heading20.copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              LevelBadge(level: level),
            ],
          ),
          if (subtitle != null) ...[
            AppSpaces.vertical4,
            Text(
              subtitle!,
              style: AppStyle.body14.copyWith(
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
          AppSpaces.vertical20,
          Row(
            children: [
              Text(
                '$totalXp XP',
                style: AppStyle.heading16.copyWith(color: Colors.white),
              ),
              const Spacer(),
              if (xpToNext != null)
                Text(
                  'Faltam $xpToNext XP para o próximo nível',
                  style: AppStyle.subtitle12.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                )
              else
                Text(
                  'Nível máximo alcançado!',
                  style: AppStyle.subtitle12.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
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
                    Container(
                      height: 10,
                      color: Colors.white.withValues(alpha: 0.25),
                    ),
                    FractionallySizedBox(
                      widthFactor: value,
                      child: Container(
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.levelGold,
                        ),
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
