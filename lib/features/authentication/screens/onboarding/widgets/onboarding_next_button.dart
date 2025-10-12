import 'package:flutter/material.dart';
import 'package:haybuy_client/features/authentication/controllers/onboarding_controller.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: DeviceUtils.getBottomNavigationBarHeight(), 
      right: Sizes.defaultSpace, 
      child: ElevatedButton(
        onPressed: (){
          OnboardingController.instance.nextPage();
        }, 
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: dark ? ConstColors.iconPrimaryLight : ConstColors.dark, // <-- Button color
        ),
        child: const Icon(Iconsax.arrow_right_3),
      )
    );
  }
}