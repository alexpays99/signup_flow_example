import 'package:flutter/material.dart';

/// Configure circle where avatar will be available, and rectanble as borders
/// of this circle
class InvertedCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.width / 2),
          radius: size.width / 2,
        ),
      )
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.width))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
