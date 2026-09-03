import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stack_gamification_platform/core/di/dependency_injection.dart';
import 'package:stack_gamification_platform/core/navigation/routes.dart';
import 'package:stack_gamification_platform/core/theme/app_style.dart';
import 'package:stack_gamification_platform/core/theme/spaces.dart';
import 'package:stack_gamification_platform/design_system/buttons/app_outline_button.dart';
import 'package:stack_gamification_platform/design_system/loader/app_loader.dart';
import 'package:stack_gamification_platform/features/squad/presentation/widgets/create_squad_sheet.dart';
import 'package:stack_gamification_platform/features/squad/presentation/widgets/squad_list_tile.dart';
import 'package:stack_gamification_platform/features/squad/state_management/cubit/squad_select_cubit.dart';

class SquadSelectPage extends StatelessWidget {
  const SquadSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SquadSelectCubit>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Escolha sua squad')),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppPadding.m),
            child: BlocConsumer<SquadSelectCubit, SquadSelectState>(
              listener: (context, state) {
                if (state.joined) {
                  context.goNamed(RouteNames.dashboard);
                }
              },
              builder: (context, state) {
                if (state.isLoading) return const AppLoader();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Entre em uma squad existente ou crie a sua para '
                      'começar a mapear suas skills.',
                      style: AppStyle.body16,
                    ),
                    AppSpaces.vertical24,
                    Expanded(
                      child: state.squads.isEmpty
                          ? Center(
                              child: Text(
                                'Nenhuma squad criada ainda.\n'
                                'Seja o primeiro a criar uma!',
                                textAlign: TextAlign.center,
                                style: AppStyle.body14,
                              ),
                            )
                          : ListView.builder(
                              itemCount: state.squads.length,
                              itemBuilder: (context, index) {
                                final squad = state.squads[index];
                                return SquadListTile(
                                  squad: squad,
                                  onTap: state.isJoining
                                      ? () {}
                                      : () => context
                                            .read<SquadSelectCubit>()
                                            .joinSquad(squad),
                                );
                              },
                            ),
                    ),
                    AppSpaces.vertical16,
                    AppOutlineButton(
                      label: '+ Criar nova squad',
                      onPressed: state.isJoining
                          ? null
                          : () async {
                              final result = await showCreateSquadSheet(
                                context,
                              );
                              if (result != null && context.mounted) {
                                context
                                    .read<SquadSelectCubit>()
                                    .createAndJoinSquad(
                                      name: result.name,
                                      stack: result.stack,
                                    );
                              }
                            },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
