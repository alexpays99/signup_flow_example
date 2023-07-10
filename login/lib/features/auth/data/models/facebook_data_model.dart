import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/date_formats.dart';

part 'facebook_data_model.freezed.dart';

part 'facebook_data_model.g.dart';

@freezed
class FacebookDataModel with _$FacebookDataModel {
  const FacebookDataModel._();

  const factory FacebookDataModel({
    required String email,
    required String facebookAccountId,
    required String fullName,
    required String dateOfBirth,
  }) = _FacebookDataModel;

  factory FacebookDataModel.fromJson(Map<String, dynamic> json) =>
      _$FacebookDataModelFromJson(json);

  factory FacebookDataModel.fromFacebookJson(Map<String, dynamic> json) {
    final date =
        DateFormats.facebookDateFormat.parse(json['birthday'] as String);
    return FacebookDataModel(
      email: json['email'],
      facebookAccountId: json['id'],
      fullName: json['name'],
      dateOfBirth: DateFormats.backDateFormat.format(date),
    );
  }
}
