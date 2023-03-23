import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:seventh_flutter_challenge/data/api/api_constants.dart';
import 'package:seventh_flutter_challenge/data/api/user_api.dart';
import 'package:seventh_flutter_challenge/data/models/user_token.dart';

class UserRepository {
  final Dio _client = ApiConstants.getDioClient();

  final BehaviorSubject<UserToken?> _userSubject = BehaviorSubject();

  Stream<UserToken?> get userStream async* {
    yield* _userSubject.stream;
  }

  UserToken? get user => _userSubject.valueOrNull;

  Future<UserToken> login({
    required String username,
    required String password,
  }) async {
    UserToken userToken = await UserApi.postLogin(
      client: _client,
      username: username,
      password: password,
    );
    _userSubject.add(userToken);
    return userToken;
  }

  void logout() {
    _userSubject.add(null);
  }
}
