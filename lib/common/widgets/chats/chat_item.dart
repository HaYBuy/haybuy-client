import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/images/rounded_image.dart';
import 'package:haybuy_client/common/widgets/texts/brand_title_text_with_verify_icon.dart';
import 'package:haybuy_client/features/shop/screens/chat/chat.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';
import '../../../utils/constants/enums.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () =>  Get.to(()=> const ChatScreen()),
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusLg),
          color: dark ? ConstColors.darkerGrey : ConstColors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.sm),
          child: Row(
            children: [
              // Profile Image
              RoundedImage(
                imageUrl: Images.google,
                width: 40,
                height: 40,
                padding: EdgeInsets.all(Sizes.sm),
                backgroundColor: dark ? ConstColors.darkGrey : ConstColors.lightGrey,
              ),
              const SizedBox(width: Sizes.spaceBtwItems),
          
              // Profile Details
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BrandTitleWithVerifiedIcon(title: 'Setsiri', brandTextSize: TextSizes.large),
                    const Flexible(child: Text('Hello', maxLines: 1)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}