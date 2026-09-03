import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_gamification_platform/features/authentication/domain/repository/auth_repository.dart';
import 'package:stack_gamification_platform/features/authentication/signin/state_management/cubit/signin_cubit.dart'
    show AuthenticateStatus;
import 'package:stack_gamification_platform/features/user/domain/repository/user_repository.dart';
part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  SignUpCubit(this._authRepository, this._userRepository)
    : super(const SignUpState.init());

  Future<void> signUp() async {
    emit(state.copyWith(isLoading: true));
    final uid = await _authRepository.signUpWithEmail(
      email: state.email ?? '',
      password: state.password ?? '',
    );
    if (uid != null) {
      await _userRepository.createProfile(
        uid: uid,
        name: state.name ?? '',
        email: state.email ?? '',
      );
    }
    emit(
      state.copyWith(
        isLoading: false,
        status: uid != null
            ? AuthenticateStatus.authenticated
            : AuthenticateStatus.notLogged,
      ),
    );
  }

  void updateName(String? value) => emit(state.copyWith(name: value));
  void updateEmail(String? value) => emit(state.copyWith(email: value));
  void updatePassword(String? value) => emit(state.copyWith(password: value));
}
