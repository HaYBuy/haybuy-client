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
              OnboardingPage(image: Images.onboardingImage1, title: Texts.onboardingTitle1, subtitle: Texts.onboardingSubTitle1),
              OnboardingPage(image: Images.onboardingImage2, title: Texts.onboardingTitle2, subtitle: Texts.onboardingSubTitle2),
              OnboardingPage(image: Images.onboardingImage3, title: Texts.onboardingTitle3, subtitle: Texts.onboardingSubTitle3),
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
