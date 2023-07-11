import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/core/domain/entity/user.dart';

import '../../../../../../core/utils/styles/colors.dart';
import '../../../../../feed/domain/entity/post/post_entity.dart';

class PostItem extends StatelessWidget {
  final UserEntity? user;
  final PostEntity? post;

  const PostItem({
    super.key,
    required this.user,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: post?.source?[0] == null
              ? Container()
              : Image.network(
                  post?.source?[0] ?? '',
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      color: CustomPalette.white,
                      child: const Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Container(
                      color: CustomPalette.white,
                    );
                  },
                ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}
