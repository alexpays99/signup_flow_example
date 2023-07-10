import 'package:flutter/material.dart';
import 'package:login/core/utils/styles/colors.dart';

class AppTheme {
  static const TextStyle regularStylesDefault = TextStyle(
    fontFamily: 'SFProText',
    fontWeight: FontWeight.w400,
  );

  static final appTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: CustomPalette.white,
      elevation: 0.0,
      shadowColor: CustomPalette.transparent,
      iconTheme: IconThemeData(color: CustomPalette.black),
    ),
    scaffoldBackgroundColor: CustomPalette.white,
    textTheme: TextTheme(
      ///Default / Regular / LargeTitle
      /// Make width 700 for Default / Bold / LargeTitle
      displayLarge: regularStylesDefault.copyWith(
        fontFamily: 'SFProDisplay',
        fontSize: 34.0,
      ),

      ///Default / Regular / Title1
      /// Make width 700 for Default / Bold / Title1
      titleLarge: regularStylesDefault.copyWith(
        fontFamily: 'SFProDisplay',
        fontSize: 28.0,
      ),

      ///Default / Regular / Title2
      /// Make width 700 for Default / Bold / Title2
      headlineLarge: regularStylesDefault.copyWith(
        fontFamily: 'SFProDisplay',
        fontSize: 22.0,
        color: Colors.black,
      ),

      ///Default / Regular / Title3
      /// Make width 600 for Default / Bold / Title3
      displayMedium: regularStylesDefault.copyWith(
        fontFamily: 'SFProDisplay',
        fontSize: 20.0,
      ),

      ///Default / Regular / Headline
      /// Same fo Default / Bold / Headline
      titleMedium: regularStylesDefault.copyWith(
        fontSize: 17.0,
        fontWeight: FontWeight.w600,
      ),

      ///Default / Regular / Body
      /// Make width 600 for Default / Bold / Body
      bodyLarge: regularStylesDefault.copyWith(
        fontSize: 17.0,
      ),

      ///Default / Regular / Callout
      /// Make width 600 for Default / Bold / Callout
      headlineMedium: regularStylesDefault.copyWith(
        fontSize: 16.0,
      ),

      ///Default / Regular / Subheadline
      /// Make width 600 for Default / Bold / Subheadline
      bodyMedium: regularStylesDefault.copyWith(
        fontSize: 15.0,
      ),

      ///Default / Regular / Footnote
      /// Make width 600 for Default / Bold / Footnote
      displaySmall: regularStylesDefault.copyWith(
        color: CustomPalette.black,
        fontSize: 13.0,
      ),

      ///Default / Regular / Caption1
      /// Make width 500 for Default / Bold / Caption1
      titleSmall: regularStylesDefault.copyWith(
        fontSize: 12.0,
      ),

      ///Default / Regular / Caption2
      /// Make width 600 for Default / Bold / Caption2
      bodySmall: regularStylesDefault.copyWith(
        fontSize: 11.0,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomPalette.black10,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(
          color: CustomPalette.black10,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(
          color: CustomPalette.black10,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(
          color: CustomPalette.errorRed,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(
          width: 1,
          color: CustomPalette.errorRed,
        ),
      ),
      filled: true,
      fillColor: CustomPalette.whiteInput,
      hintStyle: regularStylesDefault.copyWith(
        fontSize: 12.0,
        color: CustomPalette.black45,
      ),
      helperMaxLines: 3,
      errorMaxLines: 3,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomPalette.blue,
        disabledBackgroundColor: CustomPalette.blue.withOpacity(0.4),
        disabledForegroundColor: CustomPalette.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: CustomPalette.whiteInput,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        textStyle: regularStylesDefault.copyWith(
          fontSize: 13.0,
          fontWeight: FontWeight.w600,
        ),
        foregroundColor: CustomPalette.blue,
        disabledForegroundColor: CustomPalette.inactiveGrey,
      ),
    ),
  );
}
