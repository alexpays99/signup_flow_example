import 'package:flutter/material.dart';
import 'package:login/core/utils/styles/colors.dart';

class OutlineGradientButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  const OutlineGradientButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final styles = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44.0,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: CustomPalette.brandGradient,
          ),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Center(
              child: Text(
                text,
                style: styles.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: CustomPalette.brandPurple,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
