import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_model.freezed.dart';

part 'error_model.g.dart';

@freezed
class AuthErrorModel with _$AuthErrorModel {
  const factory AuthErrorModel({required String error}) = _AuthErrorModel;

  factory AuthErrorModel.fromJson(Map<String, dynamic> json) =>
      _$AuthErrorModelFromJson(json);
}
