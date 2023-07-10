import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/config/regexp_rules.dart';
import '../../../../../core/domain/entity/failure.dart';
import '../../../../../core/injection_container.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../domain/entity/button_state_model.dart';
import '../../../domain/entity/field_verifiable_model.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../../domain/usecases/validate_user_nickname.dart';

part 'create_nickname_state.dart';
part 'create_nickname_cubit.freezed.dart';

class CreateNicknameCubit extends Cubit<CreateNicknameState> {
  CreateNicknameCubit()
      : super(
          CreateNicknameState(
            nickname: FieldVerifiableModel<String>(
              value: '',
              validationState: ValidationState.unknown,
            ),
            nextNicknameButton: ButtonState.inactive,
          ),
        );
  final validateUserNickname =
      ValidateUserNickname(authRepository: getIt.get<AuthRepository>());
  String nickname = '';

  void nicknameInput(String nicknameInputData) {
    nickname = nicknameInputData;

    if (nicknameInputData.isEmpty) {
      emitState(
        nickname: FieldVerifiableModel(
          value: nicknameInputData,
          validationState: ValidationState.unknown,
        ),
        buttonState: ButtonState.inactive,
      );
    } else {
      if (nicknameInputData.length < 8) {
        emitState(
          nickname: FieldVerifiableModel(
            value: nicknameInputData,
            validationState: ValidationState.invalid,
            message: LocaleKeys.nicknameMinsymbolsText.tr(),
          ),
          buttonState: ButtonState.inactive,
        );
      } else if (nicknameInputData.length > 20) {
        emitState(
          nickname: FieldVerifiableModel(
            value: nicknameInputData,
            validationState: ValidationState.invalid,
            message: LocaleKeys.nicknameMaxsymbolsText.tr(),
          ),
          buttonState: ButtonState.inactive,
        );
      } else if (RegexpRules.hasEmodji.hasMatch(nicknameInputData)) {
        emitState(
          nickname: FieldVerifiableModel(
            value: nicknameInputData,
            validationState: ValidationState.invalid,
            message: LocaleKeys.nicknameOnlyLatinaText.tr(),
          ),
          buttonState: ButtonState.inactive,
        );
      } else if (nicknameInputData.contains(' ')) {
        emitState(
          nickname: FieldVerifiableModel(
            value: nicknameInputData,
            validationState: ValidationState.invalid,
            message: LocaleKeys.nicknameOnlyLatinaText.tr(),
          ),
          buttonState: ButtonState.inactive,
        );
      } else {
        emitState(
          nickname: FieldVerifiableModel(
            value: nicknameInputData,
            validationState: ValidationState.valid,
          ),
          buttonState: ButtonState.active,
        );
      }
    }
  }

  Future<Either<Failure, bool>> nextButtonPressed() async {
    emitState(
      nickname: FieldVerifiableModel(
        value: nickname,
        validationState: ValidationState.valid,
      ),
      buttonState: ButtonState.loading,
    );

    final phoneExist = await validateUserNickname(nickname);

    return phoneExist.fold(
      (l) {
        emitState(
          nickname: FieldVerifiableModel(
            value: nickname,
            validationState: ValidationState.valid,
          ),
          buttonState: ButtonState.active,
        );

        return Left(l);
      },
      (r) {
        emitState(
          nickname: FieldVerifiableModel(
            value: nickname,
            validationState: ValidationState.invalid,
            message: LocaleKeys.nicknameAlreadyUsed.tr(),
          ),
          buttonState: ButtonState.inactive,
        );

        return Right(r);
      },
    );
  }

  void emitState({
    required FieldVerifiableModel<String> nickname,
    ButtonState? buttonState,
  }) {
    emit(state.copyWith(
      nickname: nickname,
      nextNicknameButton: buttonState ?? ButtonState.active,
    ));
  }
}
