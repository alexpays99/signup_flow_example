import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../translations/locale_keys.g.dart';
import '../../../domain/entity/button_state_model.dart';
import '../../../domain/entity/field_verifiable_model.dart';

part 'enter_city_state.dart';
part 'enter_city_cubit.freezed.dart';

class EnterCityCubit extends Cubit<EnterCityState> {
  EnterCityCubit()
      : super(
          EnterCityState(
            city: FieldVerifiableModel<String>(
              value: '',
              validationState: ValidationState.unknown,
            ),
            nextButton: ButtonState.active,
          ),
        );

  void cityInput({required String cityInputData}) {
    if (cityInputData.isEmpty) {
      _updateNameState(cityInputData, ValidationState.unknown);
      _updateButtonState(ButtonState.active);
    } else {
      // final hasDigits = cityInputData.contains(RegexpRules.hasDigit);
      // final hasSpecialSymbols =
      //     cityInputData.contains(RegexpRules.hasNameSpecialCharacter);

      // if (cityInputData.length < 2) {
      //   _updateNameState(cityInputData, ValidationState.invalid,
      //       message: LocaleKeys.enterCityMinsymbolsText.tr());
      //   _updateButtonState(ButtonState.inactive);
      // } else if (cityInputData.length > 50) {
      //   _updateNameState(cityInputData, ValidationState.invalid,
      //       message: LocaleKeys.enterCityMaxsymbolsText.tr());
      //   _updateButtonState(ButtonState.inactive);
      // } else if (hasDigits || hasSpecialSymbols) {
      //   _updateNameState(cityInputData, ValidationState.invalid,
      //       message: LocaleKeys.enterCityExcludeWrongCharacters.tr());
      //   _updateButtonState(ButtonState.inactive);
      // } else {
      //   _updateNameState(cityInputData, ValidationState.valid);
      //   _updateButtonState(ButtonState.active);
      // }
      final hasValidCharacters =
          RegExp(r"^[a-zA-Zа-яА-Я-\s\']+$").hasMatch(cityInputData);
      final containsOnlySpaces = RegExp(r'^\s*$').hasMatch(cityInputData);
      if (!hasValidCharacters || containsOnlySpaces) {
        _updateNameState(cityInputData, ValidationState.invalid,
            message: LocaleKeys.enterCityExcludeWrongCharacters.tr());
        _updateButtonState(ButtonState.inactive);
      } else if (cityInputData.length < 2) {
        _updateNameState(cityInputData, ValidationState.invalid,
            message: LocaleKeys.enterCityMinsymbolsText.tr());
        _updateButtonState(ButtonState.inactive);
        _updateNameState(cityInputData, ValidationState.invalid,
            message: LocaleKeys.enterCityMaxsymbolsText.tr());
        _updateButtonState(ButtonState.inactive);
      } else {
        _updateNameState(cityInputData, ValidationState.valid);
        _updateButtonState(ButtonState.active);
      }
    }
  }

  void _updateNameState(String value, ValidationState validationState,
      {String? message}) {
    final fieldVerifiableModel = FieldVerifiableModel(
      value: value,
      validationState: validationState,
      message: message,
    );
    emit(state.copyWith(city: fieldVerifiableModel));
  }

  void _updateButtonState(ButtonState buttonState) {
    final ButtonState newButtonState = buttonState;
    emit(state.copyWith(nextButton: newButtonState));
  }
}
