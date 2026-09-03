import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_gamification_platform/features/authentication/domain/repository/auth_repository.dart';
import 'package:stack_gamification_platform/features/user/domain/repository/user_repository.dart';
part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  SignInCubit(this._authRepository, this._userRepository)
    : super(const SignInState.init());

  Future<void> login() async {
    emit(state.copyWith(isLoading: true));
    final uid = await _authRepository.signInWithEmail(
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

  Future<void> loginWithGoogle() async {
    emit(state.copyWith(isLoading: true));
    final result = await _authRepository.signInWithGoogle();
    if (result != null) {
      await _userRepository.upsertGoogleProfile(
        uid: result.uid,
        name: result.name ?? '',
        email: result.email ?? '',
        photoUrl: result.photoUrl,
        isNewUser: result.isNewUser,
      );
    }
    emit(
      state.copyWith(
        isLoading: false,
        status: result != null
            ? AuthenticateStatus.authenticated
            : AuthenticateStatus.notLogged,
      ),
    );
  }

  void updateEmail(String? value) => emit(state.copyWith(email: value));
  void updatePassword(String? value) => emit(state.copyWith(password: value));
}
