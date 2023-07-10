import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../translations/locale_keys.g.dart';
import '../../../domain/entity/button_state_model.dart';
import '../../../domain/entity/field_verifiable_model.dart';

part 'add_full_name_event.dart';
part 'add_full_name_state.dart';
part 'add_full_name_bloc.freezed.dart';

class AddFullNameBloc extends Bloc<AddFullNameEvent, AddFullNameState> {
  AddFullNameBloc()
      : super(
          AddFullNameState(
            name: FieldVerifiableModel<String>(
              value: '',
              validationState: ValidationState.unknown,
            ),
            nextNameButton: ButtonState.inactive,
          ),
        ) {
    on<AddFullNameEvent>(_onUserEvent);
  }

  String name = '';

  void _onUserEvent(AddFullNameEvent event, Emitter<AddFullNameState> emit) {
    event.when(
      nameInput: (String nameInputData) {
        name = nameInputData;

        if (nameInputData.isEmpty) {
          _updateNameState(emit, nameInputData, ValidationState.unknown);
          _updateButtonState(emit, ButtonState.inactive);
        } else {
          final hasValidCharacters =
              RegExp(r"^[a-zA-Zа-яА-Я-\s\']+$").hasMatch(nameInputData);
          final containsOnlySpaces = RegExp(r'^\s*$').hasMatch(nameInputData);
          if (!hasValidCharacters || containsOnlySpaces) {
            _updateNameState(emit, nameInputData, ValidationState.invalid,
                message: LocaleKeys.fullNameExcludeWrongCharacters.tr());
            _updateButtonState(emit, ButtonState.inactive);
          } else if (nameInputData.length < 2) {
            _updateNameState(emit, nameInputData, ValidationState.invalid,
                message: LocaleKeys.fullNameMinsymbolsText.tr());
            _updateButtonState(emit, ButtonState.inactive);
          } else if (nameInputData.length >= 35) {
            _updateNameState(emit, nameInputData, ValidationState.invalid,
                message: LocaleKeys.fullNameMaxsymbolsText.tr());
            _updateButtonState(emit, ButtonState.inactive);
          } else {
            _updateNameState(emit, nameInputData, ValidationState.valid);
            _updateButtonState(emit, ButtonState.active);
          }
        }
      },
    );
  }

  void _updateNameState(Emitter<AddFullNameState> emit, String value,
      ValidationState validationState,
      {String? message}) {
    final fieldVerifiableModel = FieldVerifiableModel(
      value: value,
      validationState: validationState,
      message: message,
    );
    emit(state.copyWith(name: fieldVerifiableModel));
  }

  void _updateButtonState(
      Emitter<AddFullNameState> emit, ButtonState buttonState) {
    final ButtonState newButtonState = buttonState;
    emit(state.copyWith(nextNameButton: newButtonState));
  }
}
