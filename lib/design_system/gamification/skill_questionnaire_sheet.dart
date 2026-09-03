import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/gamification/level_calculator.dart';
import 'package:stack_gamification_platform/core/gamification/skill_questions.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/buttons/app_elevated_button.dart';
import 'package:stack_gamification_platform/design_system/gamification/level_badge.dart';

class SkillAssessmentResult {
  final Map<String, SkillAnswer> answers;
  final int projectsCount;
  const SkillAssessmentResult({
    required this.answers,
    required this.projectsCount,
  });
}

/// Bottom sheet that replaces a free-form slider with a fixed set of
/// key questions per skill — marking "Não sei" never scores. Returns the
/// answers and project count, or null if dismissed without saving.
Future<SkillAssessmentResult?> showSkillQuestionnaireSheet(
  BuildContext context, {
  required String skillName,
  Map<String, SkillAnswer> initialAnswers = const {},
  int initialProjectsCount = 0,
}) {
  return showModalBottomSheet<SkillAssessmentResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return _SkillQuestionnaireSheetContent(
        skillName: skillName,
        initialAnswers: initialAnswers,
        initialProjectsCount: initialProjectsCount,
      );
    },
  );
}

class _SkillQuestionnaireSheetContent extends StatefulWidget {
  const _SkillQuestionnaireSheetContent({
    required this.skillName,
    required this.initialAnswers,
    required this.initialProjectsCount,
  });

  final String skillName;
  final Map<String, SkillAnswer> initialAnswers;
  final int initialProjectsCount;

  @override
  State<_SkillQuestionnaireSheetContent> createState() =>
      _SkillQuestionnaireSheetContentState();
}

class _SkillQuestionnaireSheetContentState
    extends State<_SkillQuestionnaireSheetContent> {
  late final Map<String, SkillAnswer> _answers = {
    for (final q in SkillAssessment.questions)
      q.id: widget.initialAnswers[q.id] ?? SkillAnswer.unknown,
  };
  late int _projectsCount = widget.initialProjectsCount;

  int get _rating => SkillAssessment.computeRating(
    answers: _answers,
    projectsCount: _projectsCount,
  );

  @override
  Widget build(BuildContext context) {
    final tier = SkillTierX.fromRating(_rating);
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.xpTrackColor,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              AppSpaces.vertical16,
              Text(widget.skillName, style: AppStyle.heading20),
              AppSpaces.vertical4,
              Text(
                'Responda com sinceridade — marcar "Não sei" não pontua.',
                style: AppStyle.body14,
              ),
              AppSpaces.vertical16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$_rating',
                    style: AppStyle.display28.copyWith(
                      fontSize: 40,
                      color: tier.color,
                    ),
                  ),
                  Text('/10', style: AppStyle.body16),
                  AppSpaces.horizontal12,
                  SkillTierChip(tier: tier),
                ],
              ),
              const Divider(height: 32),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    for (final question in SkillAssessment.questions)
                      _QuestionTile(
                        prompt: question.prompt(widget.skillName),
                        answer: _answers[question.id]!,
                        onChanged: (value) {
                          setState(() => _answers[question.id] = value);
                        },
                      ),
                    AppSpaces.vertical8,
                    _ProjectsCountTile(
                      prompt: SkillAssessment.projectsQuestion(
                        widget.skillName,
                      ),
                      count: _projectsCount,
                      earnsBonus:
                          _projectsCount > SkillAssessment.projectsThreshold,
                      onChanged: (value) {
                        setState(() => _projectsCount = value);
                      },
                    ),
                    AppSpaces.vertical24,
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24, top: 8),
                child: AppElevatedButton(
                  label: 'Salvar avaliação',
                  onPressed: () => Navigator.of(context).pop(
                    SkillAssessmentResult(
                      answers: _answers,
                      projectsCount: _projectsCount,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _QuestionTile extends StatelessWidget {
  const _QuestionTile({
    required this.prompt,
    required this.answer,
    required this.onChanged,
  });

  final String prompt;
  final SkillAnswer answer;
  final ValueChanged<SkillAnswer> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(prompt, style: AppStyle.title14),
          AppSpaces.vertical8,
          Wrap(
            spacing: 8,
            children: [
              for (final option in SkillAnswer.values)
                ChoiceChip(
                  label: Text(option.label),
                  selected: answer == option,
                  onSelected: (_) => onChanged(option),
                  selectedColor: option == SkillAnswer.yes
                      ? AppColors.tierAvancado.withValues(alpha: 0.25)
                      : null,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProjectsCountTile extends StatelessWidget {
  const _ProjectsCountTile({
    required this.prompt,
    required this.count,
    required this.earnsBonus,
    required this.onChanged,
  });

  final String prompt;
  final int count;
  final bool earnsBonus;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(prompt, style: AppStyle.title14),
        AppSpaces.vertical8,
        Row(
          children: [
            IconButton.filledTonal(
              onPressed: count > 0 ? () => onChanged(count - 1) : null,
              icon: const Icon(Icons.remove),
            ),
            SizedBox(
              width: 48,
              child: Text(
                '$count',
                textAlign: TextAlign.center,
                style: AppStyle.heading20,
              ),
            ),
            IconButton.filledTonal(
              onPressed: count < 20 ? () => onChanged(count + 1) : null,
              icon: const Icon(Icons.add),
            ),
            AppSpaces.horizontal12,
            Expanded(
              child: Text(
                earnsBonus
                    ? 'Mais de ${SkillAssessment.projectsThreshold} projetos: ponto garantido! ✅'
                    : 'Mais de ${SkillAssessment.projectsThreshold} projetos garante esse ponto.',
                style: AppStyle.subtitle12.copyWith(
                  color: earnsBonus ? AppColors.success : null,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
