import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stack_gamification_platform/core/di/dependency_injection.dart';
import 'package:stack_gamification_platform/core/navigation/routes.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/buttons/app_outline_button.dart';
import 'package:stack_gamification_platform/design_system/gamification/skill_radar_chart.dart';
import 'package:stack_gamification_platform/design_system/gamification/xp_summary_card.dart';
import 'package:stack_gamification_platform/design_system/loader/app_loader.dart';
import 'package:stack_gamification_platform/features/profile/presentation/widgets/edit_name_dialog.dart';
import 'package:stack_gamification_platform/features/profile/state_management/cubit/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Meu perfil')),
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state.isLoading || state.user == null) {
                return const AppLoader();
              }
              final user = state.user!;
              final cubit = context.read<ProfileCubit>();
              return ListView(
                padding: EdgeInsets.all(AppPadding.m),
                children: [
                  XpSummaryCard(
                    name: user.name,
                    totalXp: user.totalXp,
                    subtitle: '${user.squadName ?? ''} · ${user.stack ?? ''}',
                    photoUrl: user.photoUrl,
                  ),
                  AppSpaces.vertical16,
                  TextButton.icon(
                    onPressed: () async {
                      final name = await showEditNameDialog(context, user.name);
                      if (name != null && name.isNotEmpty) {
                        cubit.updateName(name);
                      }
                    },
                    icon: const Icon(Icons.edit_outlined, size: 18),
                    label: const Text('Editar nome'),
                  ),
                  AppSpaces.vertical8,
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          label: 'Skills avaliadas',
                          value: '${state.ratedSkills.length}',
                        ),
                      ),
                      AppSpaces.horizontal12,
                      Expanded(
                        child: _StatCard(
                          label: 'E-mail',
                          value: user.email,
                          small: true,
                        ),
                      ),
                    ],
                  ),
                  AppSpaces.vertical24,
                  if (state.ratedSkills.length >= 3) ...[
                    Text('Seu radar de skills', style: AppStyle.heading16),
                    AppSpaces.vertical12,
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SkillRadarChart(skills: state.ratedSkills),
                      ),
                    ),
                    AppSpaces.vertical24,
                  ],
                  AppOutlineButton(
                    label: 'Sair da conta',
                    onPressed: () {
                      cubit.signOut();
                      context.goNamed(RouteNames.signIn);
                    },
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

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    this.small = false,
  });

  final String label;
  final String value;
  final bool small;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: small ? AppStyle.title14 : AppStyle.heading20,
              overflow: TextOverflow.ellipsis,
            ),
            AppSpaces.vertical4,
            Text(
              label,
              style: AppStyle.subtitle12.copyWith(
                color: AppColors.mutedFontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
