import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_gamification_platform/features/authentication/domain/repository/auth_repository.dart';
part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository _repository;

  SignInCubit(this._repository) : super(const SignInState.init());

  Future<void> login() async {
    emit(state.copyWith(isLoading: true));
    final uid = await _repository.signInWithEmail(
      email: state.email ?? '',
      password: state.password ?? '',
    );
    emit(
      state.copyWith(
        isLoading: false,
        status: uid != null
            ? AuthenticateStatus.authenticated
            : AuthenticateStatus.notLogged,
      ),
    );
  }

  void updateEmail(String? value) => emit(state.copyWith(email: value));
  void updatePassword(String? value) => emit(state.copyWith(password: value));
}
