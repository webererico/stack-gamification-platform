import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/gamification/level_badge.dart';
import 'package:stack_gamification_platform/design_system/gamification/user_avatar.dart';
import 'package:stack_gamification_platform/features/user/domain/model/app_user.dart';

/// Side-by-side XP bars for the selected teammates — a quick check for
/// whether a lineup mixes seniority levels or stacks everyone at the same
/// tier.
class TeamXpCompare extends StatelessWidget {
  const TeamXpCompare({required this.entries, super.key});

  final List<({AppUser member, Color color})> entries;

  @override
  Widget build(BuildContext context) {
    final maxXp = entries.isEmpty
        ? 1
        : entries
              .map((e) => e.member.totalXp)
              .reduce((a, b) => a > b ? a : b)
              .clamp(1, 1 << 30);

    return Column(
      children: [
        for (final entry in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                UserAvatar(
                  name: entry.member.name,
                  photoUrl: entry.member.photoUrl,
                  radius: 16,
                  foregroundColor: entry.color,
                ),
                AppSpaces.horizontal12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              entry.member.name,
                              style: AppStyle.title14,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          LevelBadge(level: entry.member.level, compact: true),
                        ],
                      ),
                      AppSpaces.vertical4,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(
                            begin: 0,
                            end: entry.member.totalXp / maxXp,
                          ),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, _) {
                            return Stack(
                              children: [
                                Container(
                                  height: 8,
                                  color: AppColors.xpTrackColor,
                                ),
                                FractionallySizedBox(
                                  widthFactor: value.clamp(0, 1),
                                  child: Container(
                                    height: 8,
                                    color: entry.color,
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
                AppSpaces.horizontal12,
                Text('${entry.member.totalXp} XP', style: AppStyle.subtitle12),
              ],
            ),
          ),
      ],
    );
  }
}
