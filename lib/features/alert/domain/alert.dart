import 'package:equatable/equatable.dart';

class Alert extends Equatable {
  final String title;
  final AlertType type;
  final Duration duration;
  const Alert.success({
    required this.title,
    this.duration = const Duration(seconds: 2),
  }) : type = AlertType.success;
  const Alert.error({
    required this.title,
    this.duration = const Duration(seconds: 3),
  }) : type = AlertType.error;
  const Alert.warning({
    required this.title,
    this.duration = const Duration(seconds: 2),
  }) : type = AlertType.warning;

  @override
  List<Object?> get props => [title, type, duration];
}

enum AlertType { success, error, warning }
