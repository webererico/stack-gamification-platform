import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_gamification_platform/core/di/dependency_injection.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/gamification/level_badge.dart';
import 'package:stack_gamification_platform/design_system/gamification/rate_skill_sheet.dart';
import 'package:stack_gamification_platform/design_system/gamification/skill_xp_bar.dart';
import 'package:stack_gamification_platform/design_system/gamification/xp_summary_card.dart';
import 'package:stack_gamification_platform/design_system/loader/app_loader.dart';
import 'package:stack_gamification_platform/features/dashboard/presentation/widgets/add_custom_skill_dialog.dart';
import 'package:stack_gamification_platform/features/dashboard/state_management/cubit/dashboard_cubit.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<DashboardCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Minhas Skills')),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton.extended(
              onPressed: () async {
                final cubit = context.read<DashboardCubit>();
                final name = await showAddCustomSkillDialog(context);
                if (name == null || !context.mounted) return;
                final rating = await showRateSkillSheet(
                  context,
                  skillName: name,
                  initialRating: 0,
                );
                if (rating != null) {
                  cubit.addCustomSkill(name: name, rating: rating);
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Skill'),
            );
          },
        ),
        body: SafeArea(
          child: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              if (state.isLoading || state.user == null) {
                return const AppLoader();
              }
              final user = state.user!;
              final cubit = context.read<DashboardCubit>();
              final skills = cubit.displaySkills;
              return ListView(
                padding: EdgeInsets.all(AppPadding.m),
                children: [
                  XpSummaryCard(
                    name: user.name,
                    totalXp: user.totalXp,
                    subtitle: '${user.squadName ?? ''} · ${user.stack ?? ''}',
                  ),
                  AppSpaces.vertical24,
                  Text('Suas skills', style: AppStyle.heading16),
                  AppSpaces.vertical8,
                  Text(
                    'Toque em uma skill para se autoavaliar de 0 a 10.',
                    style: AppStyle.body14,
                  ),
                  AppSpaces.vertical12,
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          for (final skill in skills)
                            SkillXpBar(
                              name: skill.name,
                              rating: skill.rating,
                              trailing: skill.rating > 0
                                  ? SkillTierChip(tier: skill.tier)
                                  : null,
                              onTap: () async {
                                final rating = await showRateSkillSheet(
                                  context,
                                  skillName: skill.name,
                                  initialRating: skill.rating,
                                );
                                if (rating != null) {
                                  cubit.rateSkill(
                                    skillId: skill.skillId,
                                    name: skill.name,
                                    rating: rating,
                                  );
                                }
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                  AppSpaces.vertical48,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
