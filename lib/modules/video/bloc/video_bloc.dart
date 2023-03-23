import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:seventh_flutter_challenge/data/models/video_url.dart';
import 'package:seventh_flutter_challenge/data/repositories/user_repository.dart';
import 'package:seventh_flutter_challenge/data/repositories/videos_repository.dart';
import 'package:video_player/video_player.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  VideoBloc({
    UserRepository? userRepository,
    VideosRepository? videosRepository,
  }) : super(VideoInitial()) {
    on<GetVideoFailed>((event, emit) {
      emit(VideoFailure());
    });
    on<RetryTapped>((event, emit) {
      _getVideoUrl();
      emit(VideoInitial());
    });
    on<VideoLoaded>((event, emit) {
      emit(VideoPlayer(
        videoUrl: _videoUrl,
        chewieController: _chewieController,
      ));
    });
    on<LogoutButtonTapped>((event, emit) {
      _userRepository.logout();
      emit(LogoutSuccess());
    });

    _userRepository = userRepository ?? GetIt.I<UserRepository>();
    _videosRepository = videosRepository ?? GetIt.I<VideosRepository>();

    _getVideoUrl();
  }

  late final UserRepository _userRepository;
  late final VideosRepository _videosRepository;
  VideoUrl? _videoUrl;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  Future<void> _getVideoUrl() async {
    try {
      String? token = _userRepository.user?.token;
      if (token == null) {
        throw Exception('Token is null');
      }

      VideoUrl videoUrl = await _videosRepository.getVideoUrl(
        fileName: 'bunny.mp4',
        token: token,
      );
      _videoUrl = videoUrl;

      VideoPlayerController videoPlayerController =
          VideoPlayerController.network(
        videoUrl.url,
      );

      await videoPlayerController.initialize();

      _videoPlayerController = videoPlayerController;
      _chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
      );

      add(VideoLoaded());
    } catch (e) {
      add(GetVideoFailed());
    }
  }

  @override
  Future<void> close() async {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.close();
  }
}
