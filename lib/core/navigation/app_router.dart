import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stack_gamification_platform/core/di/dependency_injection.dart';
import 'package:stack_gamification_platform/core/navigation/auth_gate.dart';
import 'package:stack_gamification_platform/core/navigation/routes.dart';
import 'package:stack_gamification_platform/features/authentication/signin/presentation/pages/signin_page.dart';
import 'package:stack_gamification_platform/features/authentication/signup/presentation/pages/signup_page.dart';
import 'package:stack_gamification_platform/features/core/presentation/app_shell.dart';
import 'package:stack_gamification_platform/features/core/presentation/splash_page.dart';
import 'package:stack_gamification_platform/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:stack_gamification_platform/features/profile/presentation/pages/profile_page.dart';
import 'package:stack_gamification_platform/features/squad/presentation/pages/squad_select_page.dart';
import 'package:stack_gamification_platform/features/team/presentation/pages/member_detail_page.dart';
import 'package:stack_gamification_platform/features/team/presentation/pages/team_page.dart';
import 'package:stack_gamification_platform/features/team_builder/presentation/pages/team_builder_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _dashboardNavigatorKey = GlobalKey<NavigatorState>();
final _teamNavigatorKey = GlobalKey<NavigatorState>();
final _teamBuilderNavigatorKey = GlobalKey<NavigatorState>();
final _profileNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  debugLogDiagnostics: kDebugMode,
  refreshListenable: getIt<AuthGate>(),
  redirect: (context, state) => _redirect(getIt<AuthGate>(), state),
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.splash,
      name: RouteNames.splash,
      builder: (_, _) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.signIn,
      name: RouteNames.signIn,
      builder: (_, _) => const SignInPage(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      name: RouteNames.signUp,
      builder: (_, _) => const SignUpPage(),
    ),
    GoRoute(
      path: AppRoutes.squadSelect,
      name: RouteNames.squadSelect,
      builder: (_, _) => const SquadSelectPage(),
    ),
    GoRoute(
      path: AppRoutes.teamMemberDetail,
      name: RouteNames.teamMemberDetail,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        return MemberDetailPage(memberId: state.pathParameters['memberId']!);
      },
    ),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state, navigationShell) {
        return _fadePage(
          state: state,
          child: AppShell(navigationShell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _dashboardNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.dashboard,
              name: RouteNames.dashboard,
              builder: (_, _) => const DashboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _teamNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.team,
              name: RouteNames.team,
              builder: (_, _) => const TeamPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _teamBuilderNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.teamBuilder,
              name: RouteNames.teamBuilder,
              builder: (_, _) => const TeamBuilderPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _profileNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              name: RouteNames.profile,
              builder: (_, _) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

Page<void> _fadePage({required GoRouterState state, required Widget child}) {
  return MaterialPage(key: state.pageKey, child: child);
}

String? _redirect(AuthGate authGate, GoRouterState state) {
  final location = state.matchedLocation;

  if (!authGate.authResolved) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }

  final loggedIn = authGate.uid != null;
  final loggingArea =
      location == AppRoutes.signIn || location == AppRoutes.signUp;

  if (!loggedIn) {
    if (location == AppRoutes.splash) return AppRoutes.signIn;
    return loggingArea ? null : AppRoutes.signIn;
  }

  if (authGate.isLoadingUser) {
    return location == AppRoutes.splash ? null : AppRoutes.splash;
  }

  final onSquadSelect = location == AppRoutes.squadSelect;
  if (!authGate.hasSquad) {
    return onSquadSelect ? null : AppRoutes.squadSelect;
  }

  if (loggingArea || onSquadSelect || location == AppRoutes.splash) {
    return AppRoutes.dashboard;
  }
  return null;
}
