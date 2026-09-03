import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stack_gamification_platform/core/di/dependency_injection.dart';
import 'package:stack_gamification_platform/core/navigation/routes.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/design_system/loader/app_loader.dart';
import 'package:stack_gamification_platform/features/team/presentation/widgets/team_member_tile.dart';
import 'package:stack_gamification_platform/features/team/state_management/cubit/team_cubit.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TeamCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Squad')),
        body: SafeArea(
          child: BlocBuilder<TeamCubit, TeamState>(
            builder: (context, state) {
              if (state.isLoading) return const AppLoader();
              if (state.members.isEmpty) {
                return Center(
                  child: Text(
                    'Sua squad ainda não tem membros avaliados.',
                    style: AppStyle.body14,
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(24),
                itemCount: state.members.length,
                itemBuilder: (context, index) {
                  final member = state.members[index];
                  return TeamMemberTile(
                    member: member,
                    rank: index + 1,
                    isCurrentUser: member.uid == state.currentUid,
                    onTap: () => context.pushNamed(
                      RouteNames.teamMemberDetail,
                      pathParameters: {'memberId': member.uid},
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
