import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/features/auth/domain/entity/field_verifiable_model.dart';

part 'create_post_state.freezed.dart';

@freezed
class CreatePostState with _$CreatePostState {
  const factory CreatePostState({
    required FieldVerifiableModel<String> descriptionField,
    @Default(false) bool successfullyCreated,
  }) = _CreatePostState;

  factory CreatePostState.initial() => CreatePostState(
        descriptionField: FieldVerifiableModel(
          value: '',
          validationState: ValidationState.unknown,
        ),
      );
}
