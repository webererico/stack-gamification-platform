import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/features/skills/domain/model/skill_rating.dart';

/// Radar ("aranha") chart plotting every rated skill on a 0-10 axis, giving
/// an at-a-glance view of a developer's balance across their stack.
class SkillRadarChart extends StatelessWidget {
  const SkillRadarChart({required this.skills, super.key});

  final List<SkillRating> skills;

  @override
  Widget build(BuildContext context) {
    if (skills.length < 3) {
      return Center(
        child: Text(
          'Avalie pelo menos 3 skills para ver o radar.',
          textAlign: TextAlign.center,
          style: AppStyle.body14,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: 1.1,
      child: RadarChart(
        RadarChartData(
          radarShape: RadarShape.polygon,
          tickCount: 5,
          ticksTextStyle: const TextStyle(color: Colors.transparent),
          radarBorderData: const BorderSide(color: AppColors.xpTrackColor),
          gridBorderData: const BorderSide(color: AppColors.xpTrackColor),
          tickBorderData: const BorderSide(color: AppColors.xpTrackColor),
          radarBackgroundColor: Colors.transparent,
          titlePositionPercentageOffset: 0.15,
          getTitle: (index, angle) {
            return RadarChartTitle(text: skills[index].name);
          },
          titleTextStyle: AppStyle.subtitle10,
          dataSets: [
            RadarDataSet(
              fillColor: AppColors.primaryColor.withValues(alpha: 0.25),
              borderColor: AppColors.primaryColor,
              borderWidth: 2,
              entryRadius: 3,
              dataEntries: [
                for (final skill in skills)
                  RadarEntry(value: skill.rating.toDouble()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
