import 'package:flutter/material.dart';

import '../utils/styles/colors.dart';

class CustomCircularAvatar extends StatelessWidget {
  final double radius;
  final String imagePath;

  const CustomCircularAvatar({
    super.key,
    required this.radius,
    this.imagePath = '',
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey,
      backgroundImage: imagePath != ''
          ? Image.network(
              imagePath,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                // Handle the exception here by returning a loading widget
                return SizedBox(
                  child: Center(
                    child: Container(
                      color: CustomPalette.white,
                    ),
                  ),
                );
              },
            ).image
          : null,
    );
  }
}
