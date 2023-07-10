import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/core/utils/styles/colors.dart';
import 'package:login/features/auth/domain/entity/button_state_model.dart';

class PrimaryButton extends StatelessWidget {
  final ButtonState state;
  final String text;
  final void Function()? onPress;
  final double height;

  const PrimaryButton({
    super.key,
    required this.state,
    required this.text,
    this.onPress,
    this.height = 44.0,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: state == ButtonState.active ? onPress : null,
        child: state == ButtonState.loading
            ? const SizedBox(
                width: 16.0,
                height: 16.0,
                child: CupertinoActivityIndicator(
                  color: CustomPalette.white,
                ),
              )
            : Text(
                text,
                style: style.textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: CustomPalette.white,
                ),
              ),
      ),
    );
  }
}
