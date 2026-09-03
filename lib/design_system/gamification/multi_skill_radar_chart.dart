import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/features/skills/domain/model/skill_rating.dart';

class RadarSeries {
  final String label;
  final Color color;
  final List<SkillRating> skills;
  const RadarSeries({
    required this.label,
    required this.color,
    required this.skills,
  });
}

/// Overlays one skill radar per selected teammate (one color each) so a
/// squad's coverage — and gaps — are visible at a glance.
class MultiSkillRadarChart extends StatelessWidget {
  const MultiSkillRadarChart({required this.series, super.key});

  final List<RadarSeries> series;

  @override
  Widget build(BuildContext context) {
    final axisNames = {
      for (final s in series)
        for (final skill in s.skills)
          if (skill.rating > 0) skill.name,
    }.toList()..sort();

    if (axisNames.length < 3) {
      return Center(
        child: Text(
          'As pessoas selecionadas precisam somar pelo menos 3 skills '
          'avaliadas para ver o radar.',
          textAlign: TextAlign.center,
          style: AppStyle.body14,
        ),
      );
    }

    return Column(
      children: [
        AspectRatio(
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
              getTitle: (index, angle) =>
                  RadarChartTitle(text: axisNames[index]),
              titleTextStyle: AppStyle.subtitle10,
              dataSets: [
                for (final s in series)
                  RadarDataSet(
                    fillColor: s.color.withValues(alpha: 0.18),
                    borderColor: s.color,
                    borderWidth: 2,
                    entryRadius: 3,
                    dataEntries: [
                      for (final name in axisNames)
                        RadarEntry(value: _ratingFor(s.skills, name)),
                    ],
                  ),
              ],
            ),
          ),
        ),
        AppSpaces.vertical16,
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: [
            for (final s in series)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: s.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  AppSpaces.horizontal8,
                  Text(s.label, style: AppStyle.subtitle12),
                ],
              ),
          ],
        ),
      ],
    );
  }

  double _ratingFor(List<SkillRating> skills, String name) {
    for (final skill in skills) {
      if (skill.name == name) return skill.rating.toDouble();
    }
    return 0;
  }
}
