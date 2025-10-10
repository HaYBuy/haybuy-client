import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/icons/circle_icon.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';

class ProductQuantityWithAddRemoveButton extends StatelessWidget {
  const ProductQuantityWithAddRemoveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: Sizes.md,
          color: HelperFunctions.isDarkMode(context) ? ConstColors.white : ConstColors.black,
          backgroundColor: HelperFunctions.isDarkMode(context) ? ConstColors.darkerGrey : ConstColors.lightGrey,
        ),
    
        const SizedBox(width: Sizes.spaceBtwItems),
        Text('2', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(width: Sizes.spaceBtwItems),
    
        
        CircularIcon(
          icon: Iconsax.add,
          width: 32,
          height: 32,
          size: Sizes.md,
          color: ConstColors.white,
          backgroundColor: ConstColors.primary,
        ),
      ],
    );
  }
}
