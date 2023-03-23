import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:seventh_flutter_challenge/data/models/field_state.dart';
import 'package:seventh_flutter_challenge/data/models/user_token.dart';
import 'package:seventh_flutter_challenge/data/repositories/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({UserRepository? userRepository}) : super(LoginInitial()) {
    on<FormChanged>((event, emit) {
      emit(_getIdleState());
    });
    on<LoginButtonTapped>((event, emit) {
      emit(LoginInitial());
      _login();
    });
    on<LoginFailed>((event, emit) {
      emit(LoginFailure());
    });
    on<RetryTapped>((event, emit) {
      emit(_getIdleState());
    });
    on<LoginCompleted>((event, emit) {
      emit(LoginSuccess(userToken: event.userToken));
    });

    _userRepository = userRepository ?? GetIt.I<UserRepository>();

    add(FormChanged());
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final UserRepository _userRepository;

  LoginIdle _getIdleState() {
    return LoginIdle(
      usernameFieldState: _getUsernameFieldState(),
      passwordFieldState: _getPasswordFieldState(),
      isLoginButtonEnabled: _isSearchButtonEnabled(),
    );
  }

  FieldState _getUsernameFieldState() {
    return FieldState(
      controller: _usernameController,
      text: _usernameController.text,
    );
  }

  FieldState _getPasswordFieldState() {
    return FieldState(
      controller: _passwordController,
      text: _passwordController.text,
    );
  }

  bool _isSearchButtonEnabled() {
    return _usernameController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  Future<void> _login() async {
    try {
      UserToken userToken = await _userRepository.login(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );
      add(LoginCompleted(userToken: userToken));
    } catch (e) {
      add(LoginFailed());
    }
  }
}
