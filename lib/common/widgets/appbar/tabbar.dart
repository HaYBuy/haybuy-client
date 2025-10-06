import 'package:flutter/material.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/device/device_utility.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? ConstColors.black : ConstColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: ConstColors.primary,
        labelColor: dark ? ConstColors.white : ConstColors.primary,
        unselectedLabelColor: ConstColors.darkGrey,
        tabAlignment: TabAlignment.start,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}

