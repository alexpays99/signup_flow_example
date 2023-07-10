import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/utils/styles/colors.dart';
import '../../../../../../translations/locale_keys.g.dart';

class CurrentUserInfo extends StatelessWidget {
  const CurrentUserInfo({
    super.key,
    required this.avatar,
    required this.posts,
    required this.style,
    required this.followers,
    required this.following,
  });

  final String? avatar;
  final String? posts;
  final ThemeData style;
  final String? followers;
  final String? following;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: avatar != ''
              ? Image.network(
                  avatar ?? '',
                  fit: BoxFit.cover,
                  width: 64,
                  height: 64,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      color: CustomPalette.black10,
                      child: Container(
                        width: 64,
                        height: 64,
                        color: CustomPalette.black10,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    // Handle the exception here by returning a loading widget
                    return SizedBox(
                      child: Center(
                        child: Container(
                          color: CustomPalette.black45,
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  width: 64,
                  height: 64,
                  color: CustomPalette.black10,
                ),
        ),
        const SizedBox(width: 54),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              posts ?? '0',
              style: style.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: CustomPalette.black,
              ),
            ),
            Text(
              LocaleKeys.posts.tr(),
              style: style.textTheme.headlineMedium,
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              followers ?? '',
              style: style.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: CustomPalette.black,
              ),
            ),
            Text(
              LocaleKeys.followers.tr(),
              style: style.textTheme.headlineMedium,
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              following ?? '',
              style: style.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: CustomPalette.black,
              ),
            ),
            Text(
              LocaleKeys.following.tr(),
              style: style.textTheme.headlineMedium,
            ),
          ],
        ),
      ],
    );
  }
}
