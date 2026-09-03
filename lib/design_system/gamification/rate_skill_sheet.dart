import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/gamification/level_calculator.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/buttons/app_elevated_button.dart';
import 'package:stack_gamification_platform/design_system/gamification/level_badge.dart';

/// Bottom sheet with a 0-10 slider for a developer to self-assess a skill.
/// Returns the chosen rating, or null if dismissed without saving.
Future<int?> showRateSkillSheet(
  BuildContext context, {
  required String skillName,
  required int initialRating,
}) {
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return _RateSkillSheetContent(
        skillName: skillName,
        initialRating: initialRating,
      );
    },
  );
}

class _RateSkillSheetContent extends StatefulWidget {
  const _RateSkillSheetContent({
    required this.skillName,
    required this.initialRating,
  });

  final String skillName;
  final int initialRating;

  @override
  State<_RateSkillSheetContent> createState() => _RateSkillSheetContentState();
}

class _RateSkillSheetContentState extends State<_RateSkillSheetContent> {
  late double _rating = widget.initialRating.toDouble();

  @override
  Widget build(BuildContext context) {
    final tier = SkillTierX.fromRating(_rating.round());
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.xpTrackColor,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            AppSpaces.vertical20,
            Text(widget.skillName, style: AppStyle.heading20),
            AppSpaces.vertical4,
            Text(
              'O quanto você domina essa skill hoje?',
              style: AppStyle.body14,
            ),
            AppSpaces.vertical24,
            Center(
              child: Text(
                _rating.round().toString(),
                style: AppStyle.display28.copyWith(
                  fontSize: 48,
                  color: tier.color,
                ),
              ),
            ),
            Center(child: SkillTierChip(tier: tier)),
            Slider(
              value: _rating,
              min: 0,
              max: 10,
              divisions: 10,
              activeColor: tier.color,
              label: _rating.round().toString(),
              onChanged: (value) => setState(() => _rating = value),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('0 · Nunca usei', style: AppStyle.subtitle12),
                Text('10 · Referência', style: AppStyle.subtitle12),
              ],
            ),
            AppSpaces.vertical24,
            AppElevatedButton(
              label: 'Salvar avaliação',
              onPressed: () => Navigator.of(context).pop(_rating.round()),
            ),
          ],
        ),
      ),
    );
  }
}
