import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/features/authentication/controllers/onboarding_controller.dart';
import 'package:haybuy_client/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:haybuy_client/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:haybuy_client/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:haybuy_client/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack( 
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnboardingPage(image: TImage.tOnboardingImage1, title: TText.tOnboardingTitle1, subtitle: TText.tOnboardingSubTitle1),
              OnboardingPage(image: TImage.tOnboardingImage2, title: TText.tOnboardingTitle2, subtitle: TText.tOnboardingSubTitle2),
              OnboardingPage(image: TImage.tOnboardingImage3, title: TText.tOnboardingTitle3, subtitle: TText.tOnboardingSubTitle3),
            ],
          ),

          // Skip Button
          const OnboardingSkip(),

          // Dot Navigation SmoothPageIndicators
          const OnboardingDotNavigation(),

          // Circle Button
          const OnboardingNextButton()
        ],
      )
    );
  }
}
