import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/styles/colors.dart';
import '../../../../../core/widgets/email_password_text_field.dart';
import '../../../../../core/widgets/phone_text_field.dart';
import '../../../../../translations/locale_keys.g.dart';
import '../../../domain/entity/field_verifiable_model.dart';
import '../cubit/phone_or_email_cubit.dart';

class PhoneEmailInput<T> extends StatelessWidget {
  const PhoneEmailInput({
    super.key,
    required this.cubit,
    required this.fieldModel,
    required this.style,
  });

  final PhoneOrEmailCubit cubit;
  final FieldVerifiableModel? fieldModel;
  final ThemeData style;

  @override
  Widget build(BuildContext context) {
    late Widget suffixIcon;
    late BorderSide? borderSide;
    late Color suffixColor;
    late String? helperText = '';

    switch (fieldModel?.validationState) {
      case ValidationState.unknown:
        suffixIcon = const Icon(
          Icons.close,
          size: 15,
        );
        suffixColor = CustomPalette.black45;
        borderSide = style.inputDecorationTheme.border?.borderSide;
        break;
      case ValidationState.valid:
        suffixIcon = const Center(
          child: Icon(
            Icons.close,
            color: CustomPalette.black45,
            size: 15,
          ),
        );
        suffixColor = CustomPalette.black45;
        borderSide = style.inputDecorationTheme.border?.borderSide;
        break;
      case ValidationState.invalid:
        suffixIcon = const Center(
          child: Icon(
            Icons.close,
            color: CustomPalette.errorRed,
            size: 15,
          ),
        );
        suffixColor = CustomPalette.errorRed;
        borderSide = style.inputDecorationTheme.border?.borderSide
            .copyWith(color: CustomPalette.errorRed);
        helperText = fieldModel?.message;
        break;
      default:
        Container();
    }
    switch (T) {
      case PhoneTextField:
        return PhoneTextField(
          borderSide: borderSide,
          hintText: LocaleKeys.phoneNumber.tr(),
          errorText: fieldModel?.message,
          suffixIcon: suffixIcon,
          suffixColor: suffixColor,
          onChanged: (inputData) {
            cubit.phoneInput(inputData);
          },
        );
      case EmailPasswordTextFieldS:
        return EmailPasswordTextFieldS(
          suffixIcon: suffixIcon,
          borderSide: borderSide,
          hintText: LocaleKeys.email.tr(),
          helperText: helperText ?? LocaleKeys.emailValidaitonError.tr(),
          suffixColor: suffixColor,
          onChanged: (inputData) {
            cubit.emailInput(inputData);
          },
        );
      default:
        return Container();
    }
  }
}
