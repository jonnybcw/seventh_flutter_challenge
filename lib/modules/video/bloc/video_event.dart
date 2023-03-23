part of 'video_bloc.dart';

abstract class VideoEvent extends Equatable {
  const VideoEvent();

  @override
  List<Object?> get props => [];
}

class GetVideoFailed extends VideoEvent {}

class RetryTapped extends VideoEvent {}

class VideoLoaded extends VideoEvent {}

class LogoutButtonTapped extends VideoEvent {}
