import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:login/translations/locale_keys.g.dart';

class PasswordCriteriaWidget extends StatefulWidget {
  final bool hasEightCharacters;
  final bool hasUppercase;
  final bool hasLowercase;
  final bool hasDigit;
  final bool hasSpecialCharacter;

  const PasswordCriteriaWidget({
    super.key,
    this.hasEightCharacters = false,
    this.hasUppercase = false,
    this.hasLowercase = false,
    this.hasDigit = false,
    this.hasSpecialCharacter = false,
  });

  @override
  State<PasswordCriteriaWidget> createState() => _PasswordCriteriaWidgetState();
}

class _PasswordCriteriaWidgetState extends State<PasswordCriteriaWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(LocaleKeys.eightCharacters.tr()),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: widget.hasEightCharacters
                      ? Colors.green
                      : Colors.transparent,
                  size: 15,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(LocaleKeys.oneUppercase.tr()),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              child: Center(
                child: Icon(
                  Icons.check,
                  color:
                      widget.hasUppercase ? Colors.green : Colors.transparent,
                  size: 15,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(LocaleKeys.oneLowercase.tr()),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              child: Center(
                child: Icon(
                  Icons.check,
                  color:
                      widget.hasLowercase ? Colors.green : Colors.transparent,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(LocaleKeys.oneDigit.tr()),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: widget.hasDigit ? Colors.green : Colors.transparent,
                  size: 15,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(LocaleKeys.oneSpecialCharacter.tr()),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              child: Center(
                child: Icon(
                  Icons.check,
                  color: widget.hasSpecialCharacter
                      ? Colors.green
                      : Colors.transparent,
                  size: 15,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
