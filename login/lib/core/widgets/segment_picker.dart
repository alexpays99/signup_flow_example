import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:login/core/utils/styles/colors.dart';
import 'package:login/translations/locale_keys.g.dart';

class SegmentPicker extends StatelessWidget {
  const SegmentPicker({
    super.key,
    required this.phoneTab,
    required this.emailTab,
    required this.tabHeight,
    this.onTabChanged,
  });
  final double tabHeight;
  final Function(int)? onTabChanged;
  final Widget phoneTab;
  final Widget emailTab;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // length of tabs
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            indicatorColor: CustomPalette.black,
            labelColor: CustomPalette.black,
            unselectedLabelColor: CustomPalette.black45,
            tabs: [
              Tab(text: LocaleKeys.phone.tr()),
              Tab(text: LocaleKeys.email.tr()),
            ],
            onTap: onTabChanged,
          ),
          Container(
            height: tabHeight,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                phoneTab,
                emailTab,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
