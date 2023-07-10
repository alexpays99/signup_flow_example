import 'package:flutter/material.dart';
import 'package:login/features/feed/domain/entity/post/post_entity.dart';

import '../../../../../core/domain/entity/user.dart';
import '../../../../../core/utils/styles/colors.dart';

class PostInfo extends StatefulWidget {
  final UserEntity? user;
  final PostEntity? post;

  const PostInfo({
    super.key,
    required this.user,
    required this.post,
  });

  @override
  State<PostInfo> createState() => _PostInfoState();
}

class _PostInfoState extends State<PostInfo> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final style = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: widget.user?.photo != ''
                      ? CircleAvatar(
                          child: Image.network(
                            widget.user?.photo ?? '',
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                color: CustomPalette.black10,
                                child: Container(
                                  color: CustomPalette.black10,
                                ),
                              );
                            },
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return SizedBox(
                                child: Center(
                                  child: Container(
                                    color: CustomPalette.black45,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(
                          width: 64,
                          height: 64,
                          color: CustomPalette.black10,
                        ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user?.nickname ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 8),
            Image.network(
              widget.post?.source?.first ?? '',
              width: screenWidth,
              height: screenWidth,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: const Icon(Icons.favorite_border, size: 20),
                ),
                const SizedBox(width: 8),
                const Text(
                  '${2}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.post?.createdAt.toString() ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CircleAvatar(
                      radius: 10,
                      child: Image.network(
                        widget.user?.photo ?? '',
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            color: CustomPalette.black10,
                            child: Container(
                              color: CustomPalette.black10,
                            ),
                          );
                        },
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return SizedBox(
                            child: Center(
                              child: Container(
                                color: CustomPalette.black45,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${widget.user?.nickname}",
                  style: style.textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${widget.post?.description}",
                  style: style.textTheme.bodyMedium?.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
