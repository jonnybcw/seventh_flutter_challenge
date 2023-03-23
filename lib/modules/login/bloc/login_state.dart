part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginIdle extends LoginState {
  const LoginIdle({
    required this.usernameFieldState,
    required this.passwordFieldState,
    required this.isLoginButtonEnabled,
  });

  final FieldState usernameFieldState;
  final FieldState passwordFieldState;
  final bool isLoginButtonEnabled;

  @override
  List<Object?> get props => [
        usernameFieldState,
        passwordFieldState,
        isLoginButtonEnabled,
      ];
}

class LoginFailure extends LoginState {}

class LoginSuccess extends LoginState {
  const LoginSuccess({
    required this.userToken,
  });

  final UserToken userToken;

  @override
  List<Object?> get props => [
        userToken,
      ];
}
