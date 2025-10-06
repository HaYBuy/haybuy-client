import 'package:flutter/material.dart';
import 'package:haybuy_client/common/styles/shadows.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:haybuy_client/common/widgets/icons/circle_icon.dart';
import 'package:haybuy_client/common/widgets/images/rounded_image.dart';
import 'package:haybuy_client/common/widgets/texts/brand_title_text.dart';
import 'package:haybuy_client/common/widgets/texts/brand_title_text_with_verify_icon.dart';
import 'package:haybuy_client/common/widgets/texts/product_price_text.dart';
import 'package:haybuy_client/common/widgets/texts/product_title_text.dart';
import 'package:haybuy_client/utils/constants/enums.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(Sizes.productImageRadius),
          color: dark ? ConstColors.darkerGrey : ConstColors.white,
        ),
        child: Column(
          children: [
            RoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(Sizes.sm),
              backgroundColor: dark ? ConstColors.dark : ConstColors.lightGrey,
              child: Stack(
                children: [
                  RoundedImage(
                    imageUrl: Images.onboardingImage1,
                    applyImageRadius: true,
                  ),

                  // Sale
                  Positioned(
                    top: 12,
                    child: RoundedContainer(
                      radius: Sizes.sm,
                      backgroundColor: const Color.fromARGB(
                        255,
                        0,
                        255,
                        13,
                      ).withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.sm,
                        vertical: Sizes.xs,
                      ),
                      child: Text(
                        '20%',
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.apply(color: ConstColors.black),
                      ),
                    ),
                  ),

                  // Favourite
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: CircleIcon(icon: Iconsax.heart5, color: Colors.red),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwItems / 2),

            // Details
            Padding(
              padding: const EdgeInsets.only(left: Sizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitleText(title: 'Muhahaha', smallSize: true),
                  SizedBox(height: Sizes.spaceBtwItems / 2),
                  BrandTitleWithVerifiedIcon(title: 'Apple'),
                ],
              ),
            ),
            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Pricce
                Padding(
                  padding: const EdgeInsets.only(left: Sizes.sm),
                  child: const ProductPriceText(price: '35'),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: ConstColors.dark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Sizes.cardRadiusMd),
                      bottomRight: Radius.circular(Sizes.productImageRadius),
                    ),
                  ),
                  child: SizedBox(
                    width: Sizes.iconLg * 1.2,
                    height: Sizes.iconLg * 1.2,
                    child: Center(
                      child: const Icon(Iconsax.add, color: ConstColors.white),
                    ),
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
