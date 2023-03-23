import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:seventh_flutter_challenge/data/api/api_constants.dart';
import 'package:seventh_flutter_challenge/data/api/user_api.dart';
import 'package:seventh_flutter_challenge/data/api/videos_api.dart';
import 'package:seventh_flutter_challenge/data/models/user_token.dart';
import 'package:seventh_flutter_challenge/data/models/video_url.dart';

import 'api_test.mocks.dart';

// Generate a MockDio using the Mockito package.
// Create new instances of this class in each test.
@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  group('UserApi test', () {
    Map<String, dynamic> expectedApiSuccessJson = {
      'token': 'AJINdsisl23nNAK32',
    };

    test('returns a UserToken if the http call completes successfully',
        () async {
      final client = MockDio();
      String username = 'user';
      String password = 'password';
      String path = ApiConstants.login;

      // Use Mockito to return a successful response when it calls the
      // provided Dio.
      when(client.post(
        path,
        data: {
          'username': username,
          'password': password,
        },
      )).thenAnswer((_) async => Response(
            data: expectedApiSuccessJson,
            statusCode: 200,
            requestOptions: RequestOptions(path: path),
          ));

      expect(
        await UserApi.postLogin(
          client: client,
          username: username,
          password: password,
        ),
        isA<UserToken>(),
      );
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockDio();
      String username = '';
      String password = '';
      String path = ApiConstants.login;

      // Use Mockito to return an unsuccessful response when it calls the
      // provided Dio.
      when(client.post(
        path,
        data: {
          'username': username,
          'password': password,
        },
      )).thenThrow(Exception('Invalid credentials'));

      expectLater(
        UserApi.postLogin(
          client: client,
          username: username,
          password: password,
        ),
        throwsException,
      );
    });
  });

  group('VideosApi test', () {
    Map<String, dynamic> expectedApiSuccessJson = {
      'url': 'https://www.google.com',
    };

    test('returns a VideoUrl if the http call completes successfully',
        () async {
      final client = MockDio();
      String token = 'correct_token';
      String fileName = 'bunny.mp4';
      String path = ApiConstants.video(fileName);
      Options options = Options(
        headers: {
          'X-Access-Token': token,
        },
      );

      // Use Mockito to return a successful response when it calls the
      // provided Dio.
      when(client.get(
        path,
        options: options,
      )).thenAnswer((_) async => Response(
            data: expectedApiSuccessJson,
            statusCode: 200,
            requestOptions: RequestOptions(path: path),
          ));

      expectLater(
        await VideosApi.getVideoUrl(
          client: client,
          fileName: fileName,
          token: token,
          options: options,
        ),
        isA<VideoUrl>(),
      );
    });

    test('throws an exception if the http call completes with an error',
        () async {
      final client = MockDio();
      String token = 'wrong token';
      String fileName = 'invalid.mp4';
      String path = ApiConstants.video(fileName);
      Options options = Options(
        headers: {
          'X-Access-Token': token,
        },
      );

      // Use Mockito to return an unsuccessful response when it calls the
      // provided Dio.
      when(client.get(
        path,
        options: options,
      )).thenThrow(Exception('Invalid token or file name'));

      expectLater(
        VideosApi.getVideoUrl(
          client: client,
          fileName: fileName,
          token: token,
          options: options,
        ),
        throwsException,
      );
    });
  });
}
