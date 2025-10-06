import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/texts/brand_title_text.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/enums.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class BrandTitleWithVerifiedIcon extends StatelessWidget {
  const BrandTitleWithVerifiedIcon({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = ConstColors.primary,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: BrandTitleText(
            title: title,
            color: textColor,
            brandTextSize: brandTextSize,
            maxLines: 1,
            textAlign: textAlign,
          ),
        ),
        const SizedBox(width: Sizes.xs),
        const Icon(
          Iconsax.verify5,
          color: ConstColors.primary,
          size: Sizes.iconXs,
        ),
      ],
    );
  }
}
