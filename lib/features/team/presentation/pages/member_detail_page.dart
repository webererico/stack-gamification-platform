import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/di/dependency_injection.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/gamification/skill_radar_chart.dart';
import 'package:stack_gamification_platform/design_system/gamification/skill_xp_bar.dart';
import 'package:stack_gamification_platform/design_system/gamification/xp_summary_card.dart';
import 'package:stack_gamification_platform/design_system/loader/app_loader.dart';
import 'package:stack_gamification_platform/features/skills/domain/model/skill_rating.dart';
import 'package:stack_gamification_platform/features/skills/domain/repository/skill_repository.dart';
import 'package:stack_gamification_platform/features/user/domain/model/app_user.dart';
import 'package:stack_gamification_platform/features/user/domain/repository/user_repository.dart';

/// Read-only view of a teammate's self-assessed skills — this is the whole
/// point of the platform: giving anyone in the squad a clear picture of what
/// a colleague knows, to help with allocation and growth conversations.
class MemberDetailPage extends StatelessWidget {
  const MemberDetailPage({required this.memberId, super.key});

  final String memberId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil do dev')),
      body: SafeArea(
        child: StreamBuilder<AppUser?>(
          stream: getIt<UserRepository>().watchUser(memberId),
          builder: (context, userSnapshot) {
            final user = userSnapshot.data;
            if (!userSnapshot.hasData || user == null) {
              return const AppLoader();
            }
            return StreamBuilder<List<SkillRating>>(
              stream: getIt<SkillRepository>().watchSkills(memberId),
              builder: (context, skillsSnapshot) {
                final skills = skillsSnapshot.data ?? const <SkillRating>[];
                final rated = skills.where((s) => s.rating > 0).toList()
                  ..sort((a, b) => b.rating.compareTo(a.rating));
                return ListView(
                  padding: EdgeInsets.all(AppPadding.m),
                  children: [
                    XpSummaryCard(
                      name: user.name,
                      totalXp: user.totalXp,
                      subtitle: '${user.squadName ?? ''} · ${user.stack ?? ''}',
                    ),
                    AppSpaces.vertical24,
                    if (rated.length >= 3) ...[
                      Text('Radar de skills', style: AppStyle.heading16),
                      AppSpaces.vertical12,
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SkillRadarChart(skills: rated),
                        ),
                      ),
                      AppSpaces.vertical24,
                    ],
                    Text('Skills avaliadas', style: AppStyle.heading16),
                    AppSpaces.vertical12,
                    if (rated.isEmpty)
                      Text(
                        'Este dev ainda não avaliou nenhuma skill.',
                        style: AppStyle.body14,
                      )
                    else
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              for (final skill in rated)
                                SkillXpBar(
                                  name: skill.name,
                                  rating: skill.rating,
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
