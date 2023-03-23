part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class FormChanged extends LoginEvent {}

class LoginButtonTapped extends LoginEvent {}

class LoginFailed extends LoginEvent {}

class RetryTapped extends LoginEvent {}

class LoginCompleted extends LoginEvent {
  const LoginCompleted({
    required this.userToken,
  });

  final UserToken userToken;

  @override
  List<Object?> get props => [
        userToken,
      ];
}
