import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_token.freezed.dart';

@freezed
class UserTokens with _$UserTokens {
  const factory UserTokens({
    required String accessToken,
    required String refreshToken,
  }) = _UserTokens;
}
