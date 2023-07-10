import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/primary_button.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../domain/entity/button_state_model.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.buttonModel,
    required this.action,
  });

  final ButtonState? buttonModel;
  final void Function() action;

  @override
  Widget build(BuildContext context) {
    late ButtonState state;

    switch (buttonModel) {
      case ButtonState.active:
        state = ButtonState.active;
        action;
        break;
      case ButtonState.loading:
        state = ButtonState.loading;
        break;
      case ButtonState.inactive:
        state = ButtonState.inactive;
        break;
      default:
        Container();
    }

    return PrimaryButton(
      state: state,
      text: LocaleKeys.next.tr(),
      onPress: action,
    );
  }
}
