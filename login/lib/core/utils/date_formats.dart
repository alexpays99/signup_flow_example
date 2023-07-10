import 'package:easy_localization/easy_localization.dart';

abstract class DateFormats {
  static DateFormat facebookDateFormat = DateFormat('d/M/y');
  static DateFormat backDateFormat = DateFormat('yyyy-MM-dd', 'en');

  static DateFormat uiDateFormat(String locale) => DateFormat(
        'MMMM d, y',
        locale,
      );
}
