import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_token.g.dart';

@JsonSerializable()
class UserToken extends Equatable {
  const UserToken({
    required this.token,
  });

  final String token;

  factory UserToken.fromJson(Map<String, dynamic> json) =>
      _$UserTokenFromJson(json);

  Map<String, dynamic> toJson() => _$UserTokenToJson(this);

  @override
  List<Object?> get props => [
        token,
      ];
}
