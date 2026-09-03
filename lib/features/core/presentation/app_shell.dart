import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stack_gamification_platform/core/di/dependency_injection.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/gamification/level_badge.dart';
import 'package:stack_gamification_platform/design_system/gamification/user_avatar.dart';
import 'package:stack_gamification_platform/features/authentication/domain/repository/auth_repository.dart';
import 'package:stack_gamification_platform/features/user/domain/model/app_user.dart';
import 'package:stack_gamification_platform/features/user/domain/repository/user_repository.dart';

/// Breakpoint above which the app trades the mobile bottom-tab pattern for
/// a persistent sidebar — the single biggest lever for reading as a web
/// dashboard rather than a phone app.
const double kWideLayoutBreakpoint = 900;

class _NavDestination {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavDestination(this.icon, this.activeIcon, this.label);
}

const _destinations = [
  _NavDestination(Icons.bolt_outlined, Icons.bolt_rounded, 'Minhas Skills'),
  _NavDestination(Icons.groups_outlined, Icons.groups_rounded, 'Squad'),
  _NavDestination(
    Icons.groups_2_outlined,
    Icons.groups_2_rounded,
    'Monte o Time',
  ),
  _NavDestination(Icons.person_outline_rounded, Icons.person_rounded, 'Perfil'),
];

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onSelect(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= kWideLayoutBreakpoint;

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            _Sidebar(
              currentIndex: navigationShell.currentIndex,
              onSelect: _onSelect,
            ),
            const VerticalDivider(width: 1, color: AppColors.border),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onSelect,
        items: [
          for (final d in _destinations)
            BottomNavigationBarItem(
              icon: Icon(d.icon),
              activeIcon: Icon(d.activeIcon),
              label: d.label,
            ),
        ],
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({required this.currentIndex, required this.onSelect});

  final int currentIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      color: AppColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: AppBorder.radius8,
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  Icons.arrow_upward_rounded,
                  color: AppColors.primaryColor,
                  size: 18,
                ),
              ),
              AppSpaces.horizontal12,
              Text('Stack Up', style: AppStyle.heading16),
            ],
          ),
          AppSpaces.vertical24,
          Expanded(
            child: ListView.separated(
              itemCount: _destinations.length,
              separatorBuilder: (_, _) => AppSpaces.vertical4,
              itemBuilder: (context, index) {
                final destination = _destinations[index];
                final selected = index == currentIndex;
                return _SidebarItem(
                  destination: destination,
                  selected: selected,
                  onTap: () => onSelect(index),
                );
              },
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          AppSpaces.vertical16,
          const _SidebarUserFooter(),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final _NavDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.surfaceRaised : Colors.transparent,
      borderRadius: AppBorder.radius8,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppBorder.radius8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Icon(
                selected ? destination.activeIcon : destination.icon,
                size: 19,
                color: selected
                    ? AppColors.primaryColor
                    : AppColors.mutedFontColor,
              ),
              AppSpaces.horizontal12,
              Text(
                destination.label,
                style: AppStyle.title12.copyWith(
                  color: selected
                      ? AppColors.fontColor
                      : AppColors.mutedFontColor,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SidebarUserFooter extends StatelessWidget {
  const _SidebarUserFooter();

  @override
  Widget build(BuildContext context) {
    final uid = getIt<AuthRepository>().currentUserId;
    if (uid == null) return const SizedBox.shrink();
    return StreamBuilder<AppUser?>(
      stream: getIt<UserRepository>().watchUser(uid),
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user == null) return const SizedBox(height: 32);
        return Row(
          children: [
            UserAvatar(name: user.name, photoUrl: user.photoUrl, radius: 16),
            AppSpaces.horizontal12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: AppStyle.title12,
                    overflow: TextOverflow.ellipsis,
                  ),
                  LevelBadge(level: user.level, compact: true),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
