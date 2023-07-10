import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:login/core/utils/styles/colors.dart';

import '../utils/date_formats.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime currentDate;
  final DateTime maxDate;
  final int minYear;
  final Function(DateTime dateTime) onDateTimeChanged;

  const DateTimePicker({
    super.key,
    required this.maxDate,
    required this.minYear,
    required this.currentDate,
    required this.onDateTimeChanged,
  });

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
//ios date picker
  void iosDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height * 0.25,
          color: CustomPalette.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: widget.onDateTimeChanged,
            initialDateTime: widget.currentDate,
            minimumYear: widget.minYear,
            maximumDate: widget.maxDate,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 44,
      child: OutlinedButton(
        onPressed: () {
          if (defaultTargetPlatform == TargetPlatform.macOS ||
              defaultTargetPlatform == TargetPlatform.iOS) {
            iosDatePicker(context);
          } else {
            iosDatePicker(context);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              DateFormats.uiDateFormat(context.locale.languageCode)
                  .format(widget.currentDate),
              style: style.textTheme.titleSmall?.copyWith(
                color: CustomPalette.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
