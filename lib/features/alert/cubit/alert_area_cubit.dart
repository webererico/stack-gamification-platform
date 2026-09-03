import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_gamification_platform/features/alert/domain/alert.dart';
part 'alert_area_state.dart';

class AlertAreaCubit extends Cubit<AlertAreaState> {
  AlertAreaCubit() : super(AlertAreaState());

  void showAlert(Alert alert) {
    emit(AlertAreaState(alerts: [alert, ...state.alerts]));
  }

  void removeAlert(Alert alert) {
    final alerts = List<Alert>.from(state.alerts);
    final index = alerts.indexOf(alert);
    if (index == -1) return;
    alerts.removeAt(index);
    emit(AlertAreaState(alerts: alerts));
  }

  void removeAllAlerts() => emit(AlertAreaState());
}
