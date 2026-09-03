part of 'signup_cubit.dart';

class SignUpState extends Equatable {
  final AuthenticateStatus status;
  final String? name;
  final String? email;
  final String? password;
  final bool isLoading;

  const SignUpState({
    required this.status,
    required this.isLoading,
    this.name,
    this.email,
    this.password,
  });

  const SignUpState.init({
    this.isLoading = false,
    this.status = AuthenticateStatus.notLogged,
    this.name,
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [status, isLoading, name, email, password];

  SignUpState copyWith({
    AuthenticateStatus? status,
    bool? isLoading,
    String? name,
    String? email,
    String? password,
  }) {
    return SignUpState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
