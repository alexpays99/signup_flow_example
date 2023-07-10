import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:login/core/injection_container.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../../social_network_functionality/domain/usecases/update_user_profile_info.dart';
import '../../../domain/entity/button_state_model.dart';
import '../../../domain/entity/field_verifiable_model.dart';
import '../../../domain/entity/setup_profile_data_entity.dart';

part 'add_bio_state.dart';
part 'add_bio_cubit.freezed.dart';

class AddBioCubit extends Cubit<AddBioState> {
  AddBioCubit()
      : super(
          AddBioState(
            bio: FieldVerifiableModel<String>(
              value: '',
              validationState: ValidationState.unknown,
            ),
            nextButton: ButtonState.active,
            isValidated: false,
          ),
        );

  final updateUserProfileInfo = getIt.get<UpdateUserProfileInfo>();

  void bioInput({required String bioInputData}) {
    if (bioInputData.isEmpty) {
      _updateBioState(bioInputData, ValidationState.unknown);
      _updateButtonState(ButtonState.active);
    } else {
      if (bioInputData.length >= 120) {
        _updateBioState(bioInputData, ValidationState.invalid,
            message: LocaleKeys.bioErrorText.tr());
        _updateButtonState(ButtonState.inactive);
      } else {
        _updateBioState(bioInputData, ValidationState.valid);
        _updateButtonState(ButtonState.active);
      }
    }
  }

  Future<void> askPushNotificationsPermission() async {
    await Permission.notification.request();
  }

  Future<void> sendFileToBackend(
      SetupProfileDataEntity? profileDataEntity) async {
    try {
      _updateButtonState(ButtonState.loading);

      print('sendFileToBackend: $profileDataEntity');
      final updateResult = await updateUserProfileInfo.call(profileDataEntity);
      return updateResult.fold(
        (l) {
          _updateBioState(state.bio?.value, ValidationState.invalid);
          _updateButtonState(ButtonState.inactive);
        },
        (r) {
          _updateBioState(state.bio?.value, ValidationState.valid);
          _updateButtonState(ButtonState.active);
          emit(state.copyWith(isValidated: true));
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void _updateBioState(String value, ValidationState validationState,
      {String? message}) {
    final fieldVerifiableModel = FieldVerifiableModel(
      value: value,
      validationState: validationState,
      message: message,
    );
    emit(state.copyWith(bio: fieldVerifiableModel));
  }

  void _updateButtonState(ButtonState buttonState) {
    final ButtonState newButtonState = buttonState;
    emit(state.copyWith(nextButton: newButtonState));
  }
}
