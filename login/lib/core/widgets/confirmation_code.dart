import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/core/utils/styles/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmationCode extends StatefulWidget {
  final Color? borderColor;
  final void Function(String input) onChanged;

  const ConfirmationCode({
    super.key,
    this.borderColor,
    required this.onChanged,
  });

  @override
  State<ConfirmationCode> createState() => _ConfirmationCodeState();
}

class _ConfirmationCodeState extends State<ConfirmationCode> {
  final _confirmationController = TextEditingController();
  final _focusNode = FocusNode();
  late Size size;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _confirmationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.0,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: widget.borderColor ?? CustomPalette.black45,
        ),
        color: CustomPalette.black10,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: PinCodeTextField(
            mainAxisAlignment: MainAxisAlignment.center,
            backgroundColor: CustomPalette.transparent,
            cursorColor: CustomPalette.transparent,
            appContext: context,
            length: 6,
            pinTheme: PinTheme(
              inactiveColor: CustomPalette.inactiveGrey,
              activeColor: CustomPalette.transparent,
              selectedColor: CustomPalette.inactiveGrey,
              fieldWidth: 15.0,
              fieldOuterPadding: const EdgeInsets.all(2.0),
              fieldHeight: 20.0,
            ),
            textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: CustomPalette.black,
                ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: widget.onChanged,
          ),
        ),
      ),
    );
  }
}
