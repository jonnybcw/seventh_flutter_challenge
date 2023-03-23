part of 'video_bloc.dart';

abstract class VideoState extends Equatable {
  const VideoState();

  @override
  List<Object?> get props => [];
}

class VideoInitial extends VideoState {}

class VideoPlayer extends VideoState {
  const VideoPlayer({
    required this.videoUrl,
    required this.chewieController,
  });

  final VideoUrl? videoUrl;
  final ChewieController? chewieController;

  @override
  List<Object?> get props => [
        videoUrl,
        chewieController,
      ];
}

class VideoFailure extends VideoState {}

class LogoutSuccess extends VideoState {}
