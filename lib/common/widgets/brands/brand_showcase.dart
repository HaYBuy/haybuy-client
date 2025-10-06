import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/brands/brand_card.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';

class BrandShowcase extends StatelessWidget {
  const BrandShowcase({super.key, required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      showBorder: true,
      padding: const EdgeInsets.all(Sizes.spaceBtwItems),
      borderColor: ConstColors.darkGrey,
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: Sizes.spaceBtwSections),
      child: Column(
        children: [
          /// Brand with Products Count
          const BrandCard(showBorder: false),
          const SizedBox(height: Sizes.spaceBtwItems),  

          Row(
            children: images
                .map((image) => brandTopProductImagesWidget(image, context))
                .toList(),
          ),

          /// Brand Top 3 Product Images
        ],
      ),
    );
  }
}

Widget brandTopProductImagesWidget(String image, context) {
  return Expanded(
    child: RoundedContainer(
      height: 100,
      backgroundColor: HelperFunctions.isDarkMode(context)
          ? ConstColors.darkerGrey
          : ConstColors.lightGrey,
      margin: const EdgeInsets.only(right: Sizes.sm),
      padding: const EdgeInsets.all(Sizes.md),
      child: Image(fit: BoxFit.contain, image: AssetImage(image)),
    ),
  );
}
