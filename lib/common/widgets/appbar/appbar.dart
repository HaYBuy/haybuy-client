import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/utils/device/device_utility.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, 
    this.title, 
    this.actions, 
    this.leadingIcon,
    this.onLeadingIconPressed,
    this.showBackArrow = false,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? onLeadingIconPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.md),
      child: AppBar(
          automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.arrow_left))
            : leadingIcon != null ? IconButton(
                onPressed: onLeadingIconPressed, 
                icon: Icon(leadingIcon)) : null,
        title: title,
        actions: actions,
      ), 
    ); 
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}