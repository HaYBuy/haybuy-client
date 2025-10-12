import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:haybuy_client/common/widgets/images/circular_image.dart';
import 'package:haybuy_client/common/widgets/texts/brand_title_text_with_verify_icon.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/enums.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({super.key, this.onTap, required this.showBorder});

  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onDoubleTap: () {},
      child: RoundedContainer(
        padding: const EdgeInsets.all(Sizes.sm),
        showBorder: true,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            /// --Icon
            CircularImage(
              isNetworkImage: false,
              image: Images.onboardingImage1,
              backgroundColor: Colors.transparent,
              overlayColor: isDark ? ConstColors.white : ConstColors.black,
            ),
            const SizedBox(width: Sizes.spaceBtwItems / 2),

            /// -- Text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BrandTitleWithVerifiedIcon(
                    title: 'Apple',
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    '256 products within this category belonging to this category',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
