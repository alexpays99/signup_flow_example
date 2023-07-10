import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/core/keys/default_strings.dart';
import 'package:login/core/utils/styles/colors.dart';

enum PhoneTextFieldState {
  initial,
  valid,
  error,
}

class PhoneTextField extends StatefulWidget {
  final PhoneTextFieldState phoneTextFieldState;
  // final String? helperText;
  final String? errorText;
  final BorderSide? borderSide;
  final Color suffixColor;
  final Color prefixColor;
  final Widget suffixIcon;
  final String hintText;
  final void Function(String input) onChanged;

  const PhoneTextField({
    super.key,
    this.phoneTextFieldState = PhoneTextFieldState.initial,
    // this.helperText,
    this.errorText,
    this.borderSide,
    this.suffixColor = CustomPalette.black45,
    this.prefixColor = CustomPalette.black45,
    required this.suffixIcon,
    required this.hintText,
    required this.onChanged,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);

    return TextFormField(
      controller: controller,
      style: style.textTheme.titleSmall,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ], // Only numbers can be entered
      maxLength: 9,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: widget.borderSide ??
              const BorderSide(
                color: CustomPalette.black10,
              ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: widget.borderSide ??
              const BorderSide(
                color: CustomPalette.black10,
              ),
        ),
        focusedErrorBorder: style.inputDecorationTheme.focusedErrorBorder,
        errorText: widget.errorText,
        errorStyle: style.textTheme.titleSmall?.copyWith(
          color: CustomPalette.errorRed,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: CustomPalette.errorRed,
            width: 0.1,
          ),
        ),
        helperStyle: style.textTheme.titleSmall?.copyWith(
          color: CustomPalette.transparent,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            heightFactor: 1.0,
            widthFactor: 1.0,
            child: Text(
              DefaultStrings.uaCode,
              style: style.textTheme.titleSmall
                  ?.copyWith(color: CustomPalette.black45),
            ),
          ),
        ),
        suffix: AnimatedContainer(
          duration: const Duration(milliseconds: 0),
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: CustomPalette.transparent,
            border: Border.all(color: widget.suffixColor),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Center(
            child: widget.suffixIcon,
          ),
        ),
        hintText: widget.hintText,
      ),
    );
  }
}
