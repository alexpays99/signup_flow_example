import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/core/domain/entity/user.dart';
import 'package:login/core/keys/asset_path.dart';
import 'package:login/core/widgets/cutom_circular_avatar.dart';

class MainBottomNavigationBar extends StatelessWidget {
  final Function(int) onTap;
  final int activeIndex;
  final UserEntity? activeUser;

  const MainBottomNavigationBar(
      {super.key,
      required this.onTap,
      required this.activeIndex,
      this.activeUser});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AssetPath.home,
            width: 24.0,
            height: 24.0,
          ),
          label: '1',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AssetPath.search,
            width: 24.0,
            height: 24.0,
          ),
          label: '2',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AssetPath.plus,
            width: 24.0,
            height: 24.0,
          ),
          label: '3',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AssetPath.heart,
            width: 24.0,
            height: 24.0,
          ),
          label: '4',
        ),
        BottomNavigationBarItem(
          //Mocked fpr now
          icon: Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.all(1.0),
            child: CustomCircularAvatar(
              radius: 16.0,
              imagePath: activeUser?.photo ?? '',
            ),
          ),
          label: '5',
        ),
      ],
      currentIndex: activeIndex,
      onTap: onTap,
    );
  }
}
