import 'package:flutter/material.dart';
import 'package:login/core/keys/default_strings.dart';
import 'package:login/core/utils/styles/colors.dart';

class FollowButton extends StatelessWidget {
  final void Function() onPress;
  final bool isFollowing;

  const FollowButton({
    super.key,
    required this.isFollowing,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.0,
      height: 32.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        border: isFollowing
            ? Border.all(
                width: 1.0,
                color: CustomPalette.black45,
              )
            : null,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor:
              isFollowing ? CustomPalette.white : CustomPalette.blue,
        ),
        onPressed: onPress,
        child: Text(
          isFollowing ? DefaultStrings.unfollow : DefaultStrings.follow,
          style: TextStyle(
            fontSize: 13.0,
            color: isFollowing ? CustomPalette.black45 : CustomPalette.white,
          ),
        ),
      ),
    );
  }
}
