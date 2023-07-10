import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/features/auth/domain/entity/user_token.dart';

part 'user_tokens_model.freezed.dart';

part 'user_tokens_model.g.dart';

@freezed
class UserTokensModel with _$UserTokensModel {
  const UserTokensModel._();

  const factory UserTokensModel({
    required String accessToken,
    required String refreshToken,
  }) = _UserTokensModel;

  factory UserTokensModel.fromJson(Map<String, dynamic> json) =>
      _$UserTokensModelFromJson(json);

  factory UserTokensModel.fromEntity(UserTokens tokens) {
    return UserTokensModel(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
  }

  UserTokens get entity => UserTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
}
