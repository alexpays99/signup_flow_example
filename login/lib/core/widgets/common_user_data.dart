import 'package:flutter/material.dart';
import 'package:login/core/utils/styles/colors.dart';

/// Universal text field widget for nickname, name and bio description.

class CommonUserData extends StatefulWidget {
  final String? initialText;
  final String hintText;
  final String? errorText;
  final Color borderColor;
  final Widget? preffixIcon;
  final Color suffixColor;
  final Widget? suffixIcon;
  final int? maxLength;
  final int? maxLines;
  final void Function(String input) onChanged;

  const CommonUserData({
    super.key,
    this.initialText,
    required this.hintText,
    this.errorText,
    this.borderColor = CustomPalette.black45,
    this.preffixIcon,
    this.suffixColor = CustomPalette.black45,
    this.suffixIcon,
    this.maxLength,
    this.maxLines = 1,
    required this.onChanged,
  });

  @override
  State<CommonUserData> createState() => _CommonUserDataState();
}

class _CommonUserDataState extends State<CommonUserData> {
  late final TextEditingController _textEditingController =
      TextEditingController(text: widget.initialText);

  @override
  void dispose() {
    super.dispose();
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);

    return TextFormField(
      controller: _textEditingController,
      style: style.textTheme.titleSmall,
      maxLength: widget.maxLines! >= 4 ? widget.maxLength : null,
      maxLines: widget.maxLines,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: widget.borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            color: widget.borderColor,
          ),
        ),
        focusedErrorBorder: style.inputDecorationTheme.focusedErrorBorder,
        errorText: widget.errorText,
        errorStyle: style.textTheme.titleSmall?.copyWith(
          color: CustomPalette.errorRed,
        ),
        helperStyle: const TextStyle(
          fontSize: 12,
          color: CustomPalette.black65,
        ),
        prefixIcon: widget.preffixIcon,
        suffix: widget.maxLines! < 4
            ? AnimatedContainer(
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
              )
            : null,
        hintText: widget.hintText,
      ),
    );
  }
}
