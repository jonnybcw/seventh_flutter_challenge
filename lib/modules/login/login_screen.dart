import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seventh_flutter_challenge/modules/login/bloc/login_bloc.dart';
import 'package:seventh_flutter_challenge/modules/video/video_screen.dart';
import 'package:seventh_flutter_challenge/util/components/error_component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const VideoScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Welcome!'),
              centerTitle: true,
            ),
            body: _getBody(context, state),
          );
        },
      ),
    );
  }

  Widget _getBody(BuildContext context, LoginState state) {
    if (state is LoginFailure) {
      return ErrorComponent(
        onTapRetry: () {
          bloc.add(RetryTapped());
        },
      );
    } else if (state is LoginIdle) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
              controller: state.usernameFieldState.controller,
              onChanged: (t) {
                bloc.add(FormChanged());
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              controller: state.passwordFieldState.controller,
              onChanged: (t) {
                bloc.add(FormChanged());
              },
              obscureText: true,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: state.isLoginButtonEnabled
                  ? () {
                      bloc.add(LoginButtonTapped());
                    }
                  : null,
              child: const Text('LOGIN'),
            )
          ],
        ),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }
}
