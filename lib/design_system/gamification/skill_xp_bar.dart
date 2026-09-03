import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/gamification/level_calculator.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';

/// A gamified progress bar for a single skill self-rating (0-10), with an
/// animated fill and a tier chip (Iniciante/Intermediário/Avançado/Expert).
class SkillXpBar extends StatelessWidget {
  const SkillXpBar({
    required this.name,
    required this.rating,
    this.onTap,
    this.trailing,
    super.key,
  });

  final String name;
  final int rating;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final tier = SkillTierX.fromRating(rating);
    return InkWell(
      onTap: onTap,
      borderRadius: AppBorder.radius12,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(name, style: AppStyle.title14)),
                Text('$rating/10', style: AppStyle.heading14),
                if (trailing != null) ...[
                  AppSpaces.horizontal8,
                  trailing!,
                ] else
                  AppSpaces.horizontal8,
                if (onTap != null)
                  const Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: AppColors.mutedFontColor,
                  ),
              ],
            ),
            AppSpaces.vertical8,
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: rating / 10),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) {
                  return Stack(
                    children: [
                      Container(height: 10, color: AppColors.xpTrackColor),
                      FractionallySizedBox(
                        widthFactor: value,
                        child: Container(
                          height: 10,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                tier.color.withValues(alpha: 0.75),
                                tier.color,
                              ],
                            ),
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
      ),
    );
  }
}
