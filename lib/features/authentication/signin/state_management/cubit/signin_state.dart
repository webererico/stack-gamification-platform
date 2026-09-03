part of 'signin_cubit.dart';

enum AuthenticateStatus { authenticated, notLogged }

class SignInState extends Equatable {
  final AuthenticateStatus status;
  final String? email;
  final String? password;
  final bool isLoading;

  const SignInState({
    required this.status,
    required this.isLoading,
    this.email,
    this.password,
  });

  const SignInState.init({
    this.isLoading = false,
    this.status = AuthenticateStatus.notLogged,
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [status, isLoading, email, password];

  SignInState copyWith({
    AuthenticateStatus? status,
    bool? isLoading,
    String? email,
    String? password,
  }) {
    return SignInState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
