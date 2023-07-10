import 'package:flutter/material.dart';

abstract class CustomPalette {
  static const Color black10 = Color(0xffe8e8e9);
  static const Color black45 = Color(0xff98989a);
  static const Color inactiveGrey = Color(0xff8d8d8f);
  static const Color black65 = Color(0xff6b6b6d);
  static const Color black = Color(0xff1b1b1f);
  static const Color successGreen = Color(0xff4dc821);
  static const Color whiteInput = Color(0xfffafafa);
  static const Color errorRed = Color(0xffe2353b);
  static const List<Color> brandGradient = [
    Color(0xfffd3d91),
    Color(0xffa23ef0),
    Color(0xff23beff),
  ];
  static const Color brandPurple = Color(0xffB53EDC);

  static const MaterialColor materialWhite = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );
  static const Color darkBlue = Color(0xff4a72ff);
  static const Color white = Color(0xffffffff);
  static const Color blue = Color(0xff0b80ec);
  static const Color lightblue = Color(0xff15aeee);
  static const Color loginblue = Color(0xff0b80ec);

  static const transparent = Colors.transparent;
  static Color visibilityEye = const Color.fromARGB(45, 27, 27, 31);
  static const Color pikersAvatarOverlay = Color.fromRGBO(0, 0, 0, 0.5);
}
