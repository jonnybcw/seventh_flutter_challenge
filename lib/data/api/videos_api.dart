import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:seventh_flutter_challenge/data/api/api_constants.dart';
import 'package:seventh_flutter_challenge/data/models/video_url.dart';

class VideosApi {
  static Future<VideoUrl> getVideoUrl({
    required Dio client,
    required String fileName,
    required String token,
    Options? options,
  }) async {
    try {
      final Response response = await client.get(
        ApiConstants.video(fileName),
        options: options ??
            Options(
              headers: {
                'X-Access-Token': token,
              },
            ),
      );
      VideoUrl videoUrl = VideoUrl.fromJson(response.data);
      return videoUrl;
    } catch (error, stacktrace) {
      log('$error', name: 'getVideoUrl', stackTrace: stacktrace, error: error);
      rethrow;
    }
  }
}
