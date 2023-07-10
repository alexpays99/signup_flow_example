import 'package:flutter/material.dart';
import 'package:login/core/utils/styles/colors.dart';

enum EmailPasswordTextFieldState {
  initial,
  valid,
  error,
}

class EmailPasswordTextFieldS extends StatefulWidget {
  final EmailPasswordTextFieldState passwordTextFieldState;
  final String? helperText;
  final BorderSide? borderSide;
  final Color suffixColor;
  final Widget? suffixIcon;
  final String hintText;
  final bool isPassword;
  final void Function(String input) onChanged;

  const EmailPasswordTextFieldS({
    super.key,
    this.passwordTextFieldState = EmailPasswordTextFieldState.initial,
    this.helperText,
    this.borderSide,
    this.suffixColor = CustomPalette.black45,
    this.suffixIcon,
    required this.hintText,
    this.isPassword = false,
    required this.onChanged,
  });

  @override
  State<EmailPasswordTextFieldS> createState() =>
      _EmailPasswordTextFieldSState();
}

class _EmailPasswordTextFieldSState extends State<EmailPasswordTextFieldS> {
  final controller = TextEditingController();
  late bool hidePassword = widget.isPassword ? true : false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);

    return TextFormField(
      controller: controller,
      obscureText: hidePassword,
      onChanged: widget.onChanged,
      style: style.textTheme.titleSmall,
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
        helperText: widget.helperText,
        helperStyle: style.textTheme.titleSmall?.copyWith(
          color: CustomPalette.errorRed,
        ),
        suffix: widget.isPassword
            ? GestureDetector(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Icon(
                    hidePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: CustomPalette.visibilityEye,
                    size: 15,
                  ),
                ),
                onTap: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
              )
            : AnimatedContainer(
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
