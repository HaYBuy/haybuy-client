import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/images/circular_image.dart';
import 'package:haybuy_client/common/widgets/texts/product_price_text.dart';
import 'package:haybuy_client/common/widgets/texts/product_title_text.dart';
import 'package:haybuy_client/features/shop/models/product_model.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';

class ProductMetaData extends StatelessWidget {

  final ProductModel? product;
  const ProductMetaData({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final darkMode = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            // RoundedContainer(
            //   radius: Sizes.sm,
            //   backgroundColor: ConstColors.warning.withValues(alpha: 0.8),
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: Sizes.sm,
            //     vertical: Sizes.xs,
            //   ),
            //   child: Text(
            //     '25%',
            //     style: Theme.of(
            //       context,
            //     ).textTheme.labelLarge!.apply(color: ConstColors.black),
            //   ),
            // ),
            // const SizedBox(width: Sizes.spaceBtwItems),

            /// Price
            // Text(
            //   '\$250',
            //   style: Theme.of(context).textTheme.titleSmall!.apply(
            //     decoration: TextDecoration.lineThrough,
            //   ),
            // ),
            // const SizedBox(width: Sizes.spaceBtwItems),

            ProductPriceText(price: product!.price.toStringAsFixed(2), isLarge: true),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),

        /// Title
        ProductTitleText(title: product?.name ?? 'No Name',),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),

        /// Stock Status
        Row(
          children: [
            const ProductTitleText(title: 'Status'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text(product?.status ?? 'Undefine', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(width: Sizes.spaceBtwItems),
            const ProductTitleText(title: 'Quantity'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text(product?.quantity.toString() ?? 'out of stock', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        

        const SizedBox(height: Sizes.spaceBtwItems / 1.5),

        /// Brand
        // Row(
        //   children: [
        //     CircularImage(
        //       image: Images.onboardingImage1,
        //       width: 32,
        //       height: 32,
        //       overlayColor: darkMode ? ConstColors.white : ConstColors.black,
        //     ),
        //     const SizedBox(width: Sizes.spaceBtwItems),
        //     Text('Apple', style: Theme.of(context).textTheme.titleMedium),
        //     const SizedBox(width: Sizes.xs),
        //     const Icon(Icons.verified, color: ConstColors.primary, size: 16),
        //   ],
        // ),
      ],
    );
  }
}
