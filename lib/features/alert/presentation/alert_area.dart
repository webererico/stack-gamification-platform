import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_gamification_platform/core/di/dependency_injection.dart';
import 'package:stack_gamification_platform/features/alert/cubit/alert_area_cubit.dart';
import 'package:stack_gamification_platform/features/alert/presentation/alert_widget.dart';

class AlertArea extends StatefulWidget {
  const AlertArea({super.key});

  @override
  State<AlertArea> createState() => _AlertAreaState();
}

class _AlertAreaState extends State<AlertArea> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AlertAreaCubit>(),
      child: SafeArea(
        child: Material(
          type: MaterialType.transparency,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<AlertAreaCubit, AlertAreaState>(
              builder: (BuildContext context, AlertAreaState state) {
                return Column(
                  children: <Widget>[
                    for (final a in state.alerts) ...<Widget>[
                      AlertWidget(alert: a, key: ObjectKey(a)),
                      if (state.alerts.indexOf(a) < state.alerts.length - 1)
                        const SizedBox(height: 12),
                    ],
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
