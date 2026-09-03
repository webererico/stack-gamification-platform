import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/gamification/level_badge.dart';
import 'package:stack_gamification_platform/features/user/domain/model/app_user.dart';

class TeamMemberTile extends StatelessWidget {
  const TeamMemberTile({
    required this.member,
    required this.rank,
    required this.onTap,
    this.isCurrentUser = false,
    super.key,
  });

  final AppUser member;
  final int rank;
  final bool isCurrentUser;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppBorder.radius16,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _RankBadge(rank: rank),
              AppSpaces.horizontal12,
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.primaryColor.withValues(alpha: .15),
                child: Text(
                  member.name.isNotEmpty ? member.name[0].toUpperCase() : '?',
                  style: AppStyle.heading16.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              AppSpaces.horizontal12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            member.name,
                            style: AppStyle.title14,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isCurrentUser) ...[
                          AppSpaces.horizontal8,
                          Text('(você)', style: AppStyle.subtitle12),
                        ],
                      ],
                    ),
                    Text('${member.totalXp} XP', style: AppStyle.subtitle12),
                  ],
                ),
              ),
              LevelBadge(level: member.level, compact: true),
            ],
          ),
        ),
      ),
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.rank});

  final int rank;

  @override
  Widget build(BuildContext context) {
    final medal = switch (rank) {
      1 => '🥇',
      2 => '🥈',
      3 => '🥉',
      _ => null,
    };
    return SizedBox(
      width: 28,
      child: medal != null
          ? Text(medal, style: const TextStyle(fontSize: 20))
          : Text(
              '$rank',
              textAlign: TextAlign.center,
              style: AppStyle.subtitle12,
            ),
    );
  }
}
