import 'package:flutter/material.dart';

abstract class Locales {
  static const String assetsPath = 'assets/translations/';

  static const Locale en = Locale(
    'en',
  );
  static const Locale uk = Locale(
    'uk',
  );

  static List<Locale> getLocales() => [en, uk];
}
