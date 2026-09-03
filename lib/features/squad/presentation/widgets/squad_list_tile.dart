import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/features/squad/domain/model/squad.dart';

class SquadListTile extends StatelessWidget {
  const SquadListTile({required this.squad, required this.onTap, super.key});

  final Squad squad;
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
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor.withValues(alpha: 0.12),
                  borderRadius: AppBorder.radius12,
                ),
                child: const Icon(
                  Icons.groups_rounded,
                  color: AppColors.secondaryColor,
                ),
              ),
              AppSpaces.horizontal12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(squad.name, style: AppStyle.title14),
                    Text(
                      '${squad.stack} · ${squad.memberCount} '
                      '${squad.memberCount == 1 ? 'membro' : 'membros'}',
                      style: AppStyle.subtitle12,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.mutedFontColor),
            ],
          ),
        ),
      ),
    );
  }
}
