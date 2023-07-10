import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/core/domain/entity/failure.dart';

part 'general_error.freezed.dart';

@freezed
class GeneralFailure extends Failure with _$GeneralFailure {
  const factory GeneralFailure({
    required String message,
  }) = _GeneralFailure;
}
