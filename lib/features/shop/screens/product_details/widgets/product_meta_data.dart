import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:haybuy_client/common/widgets/images/circular_image.dart';
import 'package:haybuy_client/common/widgets/texts/brand_title_text_with_verify_icon.dart';
import 'package:haybuy_client/common/widgets/texts/product_price_text.dart';
import 'package:haybuy_client/common/widgets/texts/product_title_text.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/enums.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            RoundedContainer(
              radius: Sizes.sm,
              backgroundColor: ConstColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.sm,
                vertical: Sizes.xs,
              ),
              child: Text(
                '25%',
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.apply(color: ConstColors.black),
              ),
            ),
            const SizedBox(width: Sizes.spaceBtwItems),

            /// Price
            Text(
              '\$250',
              style: Theme.of(context).textTheme.titleSmall!.apply(
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(width: Sizes.spaceBtwItems),

            const ProductPriceText(price: '\$175', isLarge: true),
          ],
        ),
        const SizedBox(width: Sizes.spaceBtwItems / 1.5),

        /// Title
        const ProductTitleText(title: 'Apple MacBook Pro 2023 M2 Chip'),
        const SizedBox(width: Sizes.spaceBtwItems / 1.5),

        /// Stock Status
        Row(
          children: [
            ProductTitleText(title: 'Status'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),

        const SizedBox(width: Sizes.spaceBtwItems / 1.5),

        /// Brand
        Row(
          children: [
            CircularImage(
              image: Images.darkAppLogo,
              width: 32,
              height: 32,
              overlayColor: darkMode ? ConstColors.white : ConstColors.black,
            ),
            const BrandTitleWithVerifiedIcon(
              title: 'Apple',
              brandTextSize: TextSizes.medium,
            ),
          ],
        ),
      ],
    );
  }
}
