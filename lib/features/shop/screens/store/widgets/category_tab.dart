import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/brands/brand_showcase.dart';
import 'package:haybuy_client/common/widgets/layouts/grid_layout.dart';
import 'package:haybuy_client/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:haybuy_client/common/widgets/texts/section_heading.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              /// -- Brands
              BrandShowcase(
                images: [
                  Images.onboardingImage1,
                  Images.onboardingImage2,
                  Images.onboardingImage3,
                ],
              ),
              const SizedBox(height: Sizes.spaceBtwItems),

              /// -- Products
              SectionHeading(title: 'You might like', onPressed: () {}),
              const SizedBox(height: Sizes.spaceBtwItems),

              GridLayout(
                itemCount: 4,
                itemBuilder: (_, context) => const ProductCardVertical(),
              ),
              SizedBox(height: Sizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
