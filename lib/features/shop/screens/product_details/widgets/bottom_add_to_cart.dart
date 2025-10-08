import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/icons/circle_icon.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';
import 'package:iconsax/iconsax.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.defaultSpace,
        vertical: Sizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? ConstColors.darkerGrey : ConstColors.lightGrey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizes.cardRadiusLg),
          topRight: Radius.circular(Sizes.cardRadiusLg),
        ),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircularIcon(
                icon: Iconsax.minus,
                backgroundColor: ConstColors.darkGrey,
                width: 40,
                height: 40,
                color: ConstColors.white,
              ),
              const SizedBox(width: Sizes.spaceBtwItems),
              Text('2', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: Sizes.spaceBtwItems),
              CircularIcon(
                icon: Iconsax.add,
                backgroundColor: ConstColors.black,
                width: 40,
                height: 40,
                color: ConstColors.white,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(Sizes.md),
              backgroundColor: ConstColors.black,
              side: const BorderSide(color: ConstColors.black),
            ),
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
