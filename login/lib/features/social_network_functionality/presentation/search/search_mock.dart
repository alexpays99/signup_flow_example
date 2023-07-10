import 'package:flutter/material.dart';

class SearchMock extends StatelessWidget {
  const SearchMock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Search mock'),
        ],
      ),
    );
  }
}
