import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:seventh_flutter_challenge/data/api/api_constants.dart';
import 'package:seventh_flutter_challenge/data/models/user_token.dart';

class UserApi {
  static Future<UserToken> postLogin({
    required Dio client,
    required String username,
    required String password,
  }) async {
    try {
      final Response response = await client.post(
        ApiConstants.login,
        data: {
          'username': username,
          'password': password,
        },
      );
      UserToken userToken = UserToken.fromJson(response.data);
      return userToken;
    } catch (error, stacktrace) {
      log('$error', name: 'postLogin', stackTrace: stacktrace, error: error);
      rethrow;
    }
  }
}
