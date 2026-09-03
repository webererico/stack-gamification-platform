import 'package:stack_gamification_platform/core/di/dependency_injection.dart';
import 'package:stack_gamification_platform/features/alert/cubit/alert_area_cubit.dart';
import 'package:stack_gamification_platform/features/alert/domain/alert.dart';

class SuccessHandler {
  void handle(String message) {
    getIt<AlertAreaCubit>().showAlert(Alert.success(title: message));
  }
}
