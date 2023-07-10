import 'package:flutter/material.dart';

class LikedPostMock extends StatelessWidget {
  const LikedPostMock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Liked post mock'),
        ],
      ),
    );
  }
}
