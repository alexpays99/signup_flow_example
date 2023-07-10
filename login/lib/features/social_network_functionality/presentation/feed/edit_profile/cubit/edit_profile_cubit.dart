import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/core/servises/main_service.dart';

import '../../../../../../core/config/regexp_rules.dart';
import '../../../../../../core/injection_container.dart';
import '../../../../../../translations/locale_keys.g.dart';
import '../../../../../auth/domain/entity/button_state_model.dart';
import '../../../../../auth/domain/entity/field_verifiable_model.dart';
import '../../../../../auth/domain/entity/setup_profile_data_entity.dart';
import '../../../../../auth/domain/repository/auth_repository.dart';
import '../../../../../auth/domain/usecases/validate_user_nickname.dart';
import '../../../../domain/usecases/update_user_profile_info.dart';

part 'edit_profile_state.dart';
part 'edit_profile_cubit.freezed.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit()
      : super(
          EditProfileState(
            photo: null,
            fullName: FieldVerifiableModel<String>(
              value: '',
              validationState: ValidationState.unknown,
            ),
            nickname: FieldVerifiableModel<String>(
              value: '',
              validationState: ValidationState.unknown,
            ),
            isUSerUpdated: false,
            city: FieldVerifiableModel<String>(
              value: '',
              validationState: ValidationState.unknown,
            ),
            bio: FieldVerifiableModel<String>(
              value: '',
              validationState: ValidationState.unknown,
            ),
            saveChangesButton: ButtonState.active,
          ),
        );

  final validateUserNickname =
      ValidateUserNickname(authRepository: getIt.get<AuthRepository>());
  final updateUserProfileInfo = getIt.get<UpdateUserProfileInfo>();
  final mainService = getIt.get<MainService>();
  String? _photo;
  String? _fullName;
  String? _nickname;
  String? _city;
  String? _bio;
  String? _newFullName;
  String? _newNickname;
  String? _newCity;
  String? _newBio;

  void setInitialValues(
    String? fullName,
    String? nickname,
    String? city,
    String? bio,
  ) {
    _fullName = fullName;
    _nickname = nickname;
    _city = city;
    _bio = bio;
  }

  void setImage(String? image) {
    _photo = image;
    print(_photo);
    emit(state.copyWith(photo: image));
  }

  void fullNameInput(String nameInputData) {
    _newFullName = nameInputData;
    if (nameInputData.isEmpty) {
      _updateState(
        fullName: FieldVerifiableModel(
          value: nameInputData,
          validationState: ValidationState.unknown,
        ),
        buttonState: ButtonState.inactive,
      );
    } else {
      final hasValidCharacters =
          RegExp(r"^[a-zA-Zа-яА-Я-\s\']+$").hasMatch(nameInputData);
      final containsOnlySpaces = RegExp(r'^\s*$').hasMatch(nameInputData);
      if (!hasValidCharacters || containsOnlySpaces) {
        _updateState(
          fullName: FieldVerifiableModel(
            value: nameInputData,
            validationState: ValidationState.invalid,
            message: LocaleKeys.fullNameExcludeWrongCharacters.tr(),
          ),
          buttonState: ButtonState.inactive,
        );
      } else if (nameInputData.length < 2) {
        _updateState(
          fullName: FieldVerifiableModel(
            value: nameInputData,
            validationState: ValidationState.invalid,
            message: LocaleKeys.fullNameMinsymbolsText.tr(),
          ),
          buttonState: ButtonState.inactive,
        );
      } else if (nameInputData.length >= 35) {
        _updateState(
          fullName: FieldVerifiableModel(
            value: nameInputData,
            validationState: ValidationState.invalid,
            message: LocaleKeys.fullNameMaxsymbolsText.tr(),
          ),
          buttonState: ButtonState.inactive,
        );
      } else {
        _updateState(
          fullName: FieldVerifiableModel(
            value: nameInputData,
            validationState: ValidationState.valid,
          ),
          buttonState: ButtonState.active,
        );
      }
    }
  }

  void nicknameInput(String nicknameInputData) {
    _newNickname = nicknameInputData;
    print(_nickname);
    if (nicknameInputData.isEmpty) {
      _updateState(
        nickname: FieldVerifiableModel(
          value: nicknameInputData,
          validationState: ValidationState.unknown,
        ),
        buttonState: ButtonState.active,
      );
    } else {
      if (nicknameInputData.length < 8) {
        _updateState(
          nickname: FieldVerifiableModel(
            value: nicknameInputData,
            validationState: ValidationState.invalid,
            message: LocaleKeys.nicknameMinsymbolsText.tr(),
          ),
          buttonState: ButtonState.inactive,
        );
      } else if (nicknameInputData.length > 20) {
        _updateState(
          nickname: FieldVerifiableModel(
            value: nicknameInputData,
            validationState: ValidationState.invalid,
            message: LocaleKeys.nicknameMaxsymbolsText.tr(),
          ),
          buttonState: ButtonState.inactive,
        );
      } else if (RegexpRules.hasEmodji.hasMatch(nicknameInputData)) {
        _updateState(
          nickname: FieldVerifiableModel(
            value: nicknameInputData,
            validationState: ValidationState.invalid,
            message: LocaleKeys.nicknameOnlyLatinaText.tr(),
          ),
          buttonState: ButtonState.inactive,
        );
      } else if (nicknameInputData.contains(' ')) {
        _updateState(
          nickname: FieldVerifiableModel(
            value: nicknameInputData,
            validationState: ValidationState.invalid,
            message: LocaleKeys.nicknameOnlyLatinaText.tr(),
          ),
          buttonState: ButtonState.inactive,
        );
      } else if (RegexpRules.nicknameRegexp.hasMatch(nicknameInputData)) {
        _updateState(
          nickname: FieldVerifiableModel(
            value: nicknameInputData,
            validationState: ValidationState.invalid,
            message: LocaleKeys.nicknameOnlyLatinaText.tr(),
          ),
          buttonState: ButtonState.inactive,
        );
      } else {
        _updateState(
          nickname: FieldVerifiableModel(
            value: nicknameInputData,
            validationState: ValidationState.valid,
          ),
          buttonState: ButtonState.active,
        );
      }
    }
  }

  void cityInput(String cityInputData) {
    _newCity = cityInputData;
    if (cityInputData.isEmpty) {
      _updateState(
        city: FieldVerifiableModel(
          value: cityInputData,
          validationState: ValidationState.unknown,
        ),
        buttonState: ButtonState.active,
      );
    } else {
      final hasValidCharacters =
          RegExp(r"^[a-zA-Zа-яА-Я-\s\']+$").hasMatch(cityInputData);
      final hasCyrylic = RegexpRules.hasCyrylic.hasMatch(cityInputData);
      final containsOnlySpaces = RegExp(r'^\s*$').hasMatch(cityInputData);
      if (!hasValidCharacters && containsOnlySpaces && hasCyrylic) {
        _updateState(
          city: FieldVerifiableModel(
            value: cityInputData,
            validationState: ValidationState.invalid,
            message: LocaleKeys.enterCityExcludeWrongCharacters.tr(),
          ),
          buttonState: ButtonState.inactive,
        );
      } else if (cityInputData.length < 2) {
        _updateState(
          city: FieldVerifiableModel(
            value: cityInputData,
            validationState: ValidationState.invalid,
            message: LocaleKeys.enterCityMinsymbolsText.tr(),
          ),
          buttonState: ButtonState.inactive,
        );
      } else if (cityInputData.length >= 50) {
        _updateState(
          city: FieldVerifiableModel(
            value: cityInputData,
            validationState: ValidationState.invalid,
            message: LocaleKeys.enterCityMaxsymbolsText.tr(),
          ),
          buttonState: ButtonState.inactive,
        );
      } else {
        _updateState(
          city: FieldVerifiableModel(
            value: cityInputData,
            validationState: ValidationState.valid,
          ),
          buttonState: ButtonState.active,
        );
      }
    }
  }

  void bioInput(String bioInputData) {
    _newBio = bioInputData;
    if (bioInputData.isEmpty) {
      _updateState(
        bio: FieldVerifiableModel(
          value: bioInputData,
          validationState: ValidationState.unknown,
        ),
        buttonState: ButtonState.active,
      );
    } else {
      if (bioInputData.length >= 120) {
        _updateState(
          bio: FieldVerifiableModel(
            value: bioInputData,
            validationState: ValidationState.unknown,
            message: LocaleKeys.bioErrorText.tr(),
          ),
          buttonState: ButtonState.active,
        );
      }
    }
  }

  Future<void> deleteAvatar() async {
    try {
      final userAvatar = await mainService.deleteUserAvatar();
      print(userAvatar);

      userAvatar.fold(
        (l) => l,
        (r) {
          print('Deleted photo: ${r.photo}');
          _photo = null;
          emit(state.copyWith(photo: null));
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveChanges() async {
    _updateState(buttonState: ButtonState.loading);
    final nicknameExist = await validateUserNickname(_newNickname ?? '');
    nicknameExist.fold(
      (l) => (l),
      (r) => _updateState(
        nickname: FieldVerifiableModel(
          value: _nickname ?? '',
          validationState: ValidationState.invalid,
          message: LocaleKeys.nicknameAlreadyUsed.tr(),
        ),
        isUSerUpdated: false,
        buttonState: ButtonState.inactive,
      ),
    );
    if (_newNickname != _nickname) {
      if (nicknameExist is Left) {
        final SetupProfileDataEntity editProfileDataEntity =
            SetupProfileDataEntity(
          photo: _photo,
          fullName: _newFullName,
          nickname: _newNickname,
          city: _newCity,
          bio: _newBio,
        );
        try {
          print('saveChanges: $editProfileDataEntity');
          final updateResult =
              await updateUserProfileInfo.call(editProfileDataEntity);

          updateResult.fold(
            (l) {
              _updateState(buttonState: ButtonState.inactive);
            },
            (r) {
              _updateState(
                nickname: FieldVerifiableModel(
                  value: _nickname ?? '',
                  validationState: ValidationState.valid,
                ),
                isUSerUpdated: true,
                buttonState: ButtonState.active,
              );
            },
          );
        } catch (e) {
          print(e);
        }
      }
    }
  }

  void _updateState({
    FieldVerifiableModel<String>? fullName,
    FieldVerifiableModel<String>? nickname,
    bool? isUSerUpdated,
    FieldVerifiableModel<String>? city,
    FieldVerifiableModel<String>? bio,
    ButtonState? buttonState,
  }) {
    emit(state.copyWith(
      fullName: fullName,
      nickname: nickname,
      isUSerUpdated: isUSerUpdated ?? false,
      city: city,
      bio: bio,
      saveChangesButton: buttonState,
    ));
  }
}
