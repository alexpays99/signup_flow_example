import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/feed_cubit.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Feed page will be here'),
          TextButton(
            onPressed: () {
              context.read<FeedCubit>().signout();
            },
            child: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
