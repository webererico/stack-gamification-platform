import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/gamification/level_badge.dart';
import 'package:stack_gamification_platform/design_system/gamification/user_avatar.dart';
import 'package:stack_gamification_platform/features/user/domain/model/app_user.dart';

class MemberSelectorTile extends StatelessWidget {
  const MemberSelectorTile({
    required this.member,
    required this.selected,
    required this.onTap,
    this.color,
    super.key,
  });

  final AppUser member;
  final bool selected;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: selected
          ? (color ?? AppColors.primaryColor).withValues(alpha: 0.08)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorder.radius16,
        side: BorderSide(
          color: selected
              ? (color ?? AppColors.primaryColor)
              : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppBorder.radius16,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _SelectionMarker(selected: selected, color: color),
              AppSpaces.horizontal12,
              UserAvatar(name: member.name, photoUrl: member.photoUrl),
              AppSpaces.horizontal12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(member.name, style: AppStyle.title14),
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

class _SelectionMarker extends StatelessWidget {
  const _SelectionMarker({required this.selected, this.color});

  final bool selected;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? (color ?? AppColors.primaryColor) : null,
        border: Border.all(
          color: selected
              ? (color ?? AppColors.primaryColor)
              : AppColors.xpTrackColor,
          width: 1.5,
        ),
      ),
      child: selected
          ? const Icon(Icons.check, size: 14, color: Colors.white)
          : null,
    );
  }
}
