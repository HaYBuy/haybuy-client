import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/images/rounded_image.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../texts/brand_title_text_with_verify_icon.dart';
import '../../texts/product_title_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Product Image
        RoundedImage(
          imageUrl: Images.onboardingImage1,
          width: 80,
          height: 80,
          padding: EdgeInsets.all(Sizes.sm),
          backgroundColor: HelperFunctions.isDarkMode(context) ? ConstColors.darkerGrey : ConstColors.lightGrey,
        ),
        const SizedBox(width: Sizes.spaceBtwItems),
    
        // Product Details
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BrandTitleWithVerifiedIcon(title: 'Apple'),
              const Flexible(child: ProductTitleText(title: 'Apple MacBook Pro 2023 M2 Chip', maxLines: 1)),
              // Attributes
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Color: ', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'Silver', style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(text: 'Size: ', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: '15 inch', style: Theme.of(context).textTheme.bodyLarge),
                  ]
                )
              )
            ],
          ),
        )
      ],
    );
  }
}