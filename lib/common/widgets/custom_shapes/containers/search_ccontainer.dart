import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_function.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key, required this.text, this.icon, this.showBackground = true, this.showBorder = true, this.onTap});

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace),
        child: Container(
          width: DeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(Sizes.md),
          decoration: BoxDecoration(
            color: showBackground ? dark ? ConstColors.dark : ConstColors.lightGrey : Colors.transparent,
            borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
            border: showBorder ? Border.all(color: ConstColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: ConstColors.darkerGrey),
              const SizedBox(width: Sizes.spaceBtwItems),
              Text(text, style: Theme.of(context).textTheme.bodySmall,),
            ],
          ),
        ),
      ),
    );
  }
}