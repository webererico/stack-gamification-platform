import 'package:firebase_auth/firebase_auth.dart';
import 'package:stack_gamification_platform/core/di/dependency_injection.dart';
import 'package:stack_gamification_platform/features/alert/cubit/alert_area_cubit.dart';
import 'package:stack_gamification_platform/features/alert/domain/alert.dart';

class ErrorHandler {
  void handle(Object error) {
    final message = _messageFor(error);
    getIt<AlertAreaCubit>().showAlert(Alert.error(title: message));
  }

  String _messageFor(Object error) {
    if (error is FirebaseAuthException) return _authMessage(error.code);
    if (error is FirebaseException) {
      return error.message ?? 'Algo deu errado. Tente novamente.';
    }
    return 'Algo deu errado. Tente novamente.';
  }

  String _authMessage(String code) {
    return switch (code) {
      'invalid-email' => 'E-mail inválido.',
      'user-disabled' => 'Esta conta foi desativada.',
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' => 'E-mail ou senha incorretos.',
      'email-already-in-use' => 'Este e-mail já está cadastrado.',
      'weak-password' => 'Senha muito fraca. Use pelo menos 6 caracteres.',
      'network-request-failed' => 'Falha de conexão. Verifique sua internet.',
      'too-many-requests' => 'Muitas tentativas. Tente novamente mais tarde.',
      _ => 'Algo deu errado. Tente novamente.',
    };
  }
}
