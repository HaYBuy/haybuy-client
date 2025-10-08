import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:haybuy_client/common/widgets/icons/circle_icon.dart';
import 'package:haybuy_client/common/widgets/images/rounded_image.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';
import 'package:iconsax/iconsax.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({super.key});


  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return CurvedEdgeWidget(
      child: Container(
        color: dark ? ConstColors.darkerGrey : ConstColors.lightGrey,
        child: Stack(
          children: [
            const SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(Sizes.productImageRadius * 2),
                child: Center(
                  child: Image(image: AssetImage(Images.onboardingImage1)),
                ),
              ),
            ),

            /// Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: Sizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (_, _) =>
                      const SizedBox(width: Sizes.spaceBtwItems),
                  itemCount: 6,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => RoundedImage(
                    width: 80,
                    backgroundColor: dark
                        ? ConstColors.dark
                        : ConstColors.white,
                    border: Border.all(color: ConstColors.primary),
                    padding: const EdgeInsets.all(Sizes.sm),
                    imageUrl: Images.onboardingImage1,
                  ),
                ),
              ),
            ),

            /// Appbar Icons
            CustomAppBar(
              showBackArrow: true,
              actions: [CircularIcon(icon: Iconsax.heart5, color: Colors.red)],
            ),
          ],
        ),
      ),
    );
  }
}
