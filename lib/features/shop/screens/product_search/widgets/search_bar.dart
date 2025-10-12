import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_function.dart';
import '../../../../../features/shop/controllers/product_search_controller.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductSearchController());

    return RoundedContainer(
      showBorder: true,
      backgroundColor: dark ? ConstColors.dark : ConstColors.white,
      padding: EdgeInsets.only(top: Sizes.xs, bottom: Sizes.xs, right: Sizes.xs, left: Sizes.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Search
          Text('Search'),
          SizedBox(width: Sizes.spaceBtwItems),


          // Search Button
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () => controller.performSearch(),
              style: ElevatedButton.styleFrom(
                backgroundColor: ConstColors.primary,
                padding: EdgeInsets.zero,
                minimumSize: const Size(48, 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.borderRadiusLg)),
                side: BorderSide(color: Colors.grey.withValues(alpha: 0.08)),
              ),
              child: const Icon(Iconsax.search_normal),
            ),
          )
        ],
      ),
    );
  }
}