import 'package:dio/dio.dart';
import 'package:seventh_flutter_challenge/data/api/api_constants.dart';
import 'package:seventh_flutter_challenge/data/api/videos_api.dart';
import 'package:seventh_flutter_challenge/data/models/video_url.dart';

class VideosRepository {
  final Dio _client = ApiConstants.getDioClient();

  Future<VideoUrl> getVideoUrl({
    required String fileName,
    required String token,
  }) async {
    VideoUrl videoUrl = await VideosApi.getVideoUrl(
      client: _client,
      fileName: fileName,
      token: token,
    );
    return videoUrl;
  }
}
