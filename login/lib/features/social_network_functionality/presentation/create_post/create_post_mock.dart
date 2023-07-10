import 'package:flutter/material.dart';

class CreatePostMock extends StatelessWidget {
  const CreatePostMock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Create ost mock'),
        ],
      ),
    );
  }
}
