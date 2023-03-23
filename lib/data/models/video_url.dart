import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_url.g.dart';

@JsonSerializable()
class VideoUrl extends Equatable {
  const VideoUrl({
    required this.url,
  });

  final String url;

  factory VideoUrl.fromJson(Map<String, dynamic> json) =>
      _$VideoUrlFromJson(json);

  Map<String, dynamic> toJson() => _$VideoUrlToJson(this);

  @override
  List<Object?> get props => [
        url,
      ];
}
