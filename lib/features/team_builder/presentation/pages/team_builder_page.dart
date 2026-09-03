import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_gamification_platform/core/di/dependency_injection.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/buttons/app_text_button.dart';
import 'package:stack_gamification_platform/design_system/gamification/multi_skill_radar_chart.dart';
import 'package:stack_gamification_platform/design_system/gamification/team_palette.dart';
import 'package:stack_gamification_platform/design_system/loader/app_loader.dart';
import 'package:stack_gamification_platform/features/skills/domain/model/skill_rating.dart';
import 'package:stack_gamification_platform/features/team_builder/presentation/widgets/member_selector_tile.dart';
import 'package:stack_gamification_platform/features/team_builder/presentation/widgets/team_xp_compare.dart';
import 'package:stack_gamification_platform/features/team_builder/state_management/cubit/team_builder_cubit.dart';

class TeamBuilderPage extends StatelessWidget {
  const TeamBuilderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TeamBuilderCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Monte seu Time')),
        body: SafeArea(
          child: BlocBuilder<TeamBuilderCubit, TeamBuilderState>(
            builder: (context, state) {
              if (state.isLoading) return const AppLoader();
              if (state.members.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppPadding.m),
                    child: Text(
                      'Sua squad ainda não tem membros para montar um time.',
                      textAlign: TextAlign.center,
                      style: AppStyle.body14,
                    ),
                  ),
                );
              }

              final colorByUid = <String, Color>{
                for (final (i, uid) in state.selectedUids.indexed)
                  uid: kTeamBuilderPalette[i % kTeamBuilderPalette.length],
              };
              final selectedMembers = [
                for (final uid in state.selectedUids)
                  state.members.firstWhere((m) => m.uid == uid),
              ];

              return ListView(
                padding: EdgeInsets.all(AppPadding.m),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Selecione até $kTeamBuilderMaxMembers pessoas da '
                          'sua squad para ver se o time está equilibrado '
                          'para um projeto.',
                          style: AppStyle.body14,
                        ),
                      ),
                      if (state.selectedUids.isNotEmpty)
                        AppTextButton(
                          label: 'Limpar',
                          onPressed: () =>
                              context.read<TeamBuilderCubit>().clearSelection(),
                        ),
                    ],
                  ),
                  AppSpaces.vertical16,
                  for (final member in state.members)
                    MemberSelectorTile(
                      member: member,
                      selected: state.selectedUids.contains(member.uid),
                      color: colorByUid[member.uid],
                      onTap: () => context
                          .read<TeamBuilderCubit>()
                          .toggleMember(member.uid),
                    ),
                  if (selectedMembers.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'Selecione pelo menos 2 pessoas para comparar.',
                        textAlign: TextAlign.center,
                        style: AppStyle.body14,
                      ),
                    )
                  else ...[
                    const Divider(height: 40),
                    Text('Comparação de XP', style: AppStyle.heading16),
                    AppSpaces.vertical16,
                    TeamXpCompare(
                      entries: [
                        for (final member in selectedMembers)
                          (member: member, color: colorByUid[member.uid]!),
                      ],
                    ),
                    AppSpaces.vertical16,
                    Text(
                      'Radar combinado de skills',
                      style: AppStyle.heading16,
                    ),
                    AppSpaces.vertical12,
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: MultiSkillRadarChart(
                          series: [
                            for (final member in selectedMembers)
                              RadarSeries(
                                label: member.name,
                                color: colorByUid[member.uid]!,
                                skills:
                                    state.skillsByUid[member.uid] ??
                                    const <SkillRating>[],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
