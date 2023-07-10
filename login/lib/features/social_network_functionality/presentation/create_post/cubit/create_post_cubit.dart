import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/features/auth/domain/entity/field_verifiable_model.dart';
import 'package:login/features/feed/domain/entity/post/image_entity.dart';
import 'package:login/features/feed/domain/entity/post/post_creation_entity.dart';

import '../../../domain/usecases/create_post.dart';
import 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final CreatePost createPost;

  CreatePostCubit({
    required this.createPost,
  }) : super(
          CreatePostState.initial(),
        );

  void onTextInput(String text) {
    if (text.length >= 500) {
      emit(
        state.copyWith(
          descriptionField: FieldVerifiableModel(
            value: text,
            message: 'Error',
            validationState: ValidationState.invalid,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          descriptionField: FieldVerifiableModel(
            value: text,
            message: null,
            validationState: ValidationState.valid,
          ),
        ),
      );
    }
  }

  void onPostCreated(String imagePath) async {
    final imageData = base64Encode(File(imagePath).readAsBytesSync());
    final ext = ".${imagePath.split('.').last}";
    final result = await createPost(
      PostCreationEntity(
        description: state.descriptionField.value,
        source: [
          ImageEntity(imageData: imageData, ext: ext),
        ],
      ),
    );
    result.fold(
      (l) {
        ///TODO add error handling
      },
      (r) {
        if (r) {
          emit(
            state.copyWith(
              successfullyCreated: r,
            ),
          );
          emit(
            CreatePostState.initial(),
          );
        }
      },
    );
  }
}
