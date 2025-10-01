import 'package:flutter/material.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( 
        children: [
          PageView(
            children: const [
              OnboardingPage(image: TImage.tOnboardingImage1, title: TText.tOnboardingTitle1, subtitle: TText.tOnboardingSubTitle1),
              OnboardingPage(image: TImage.tOnboardingImage2, title: TText.tOnboardingTitle2, subtitle: TText.tOnboardingSubTitle2),
              OnboardingPage(image: TImage.tOnboardingImage3, title: TText.tOnboardingTitle3, subtitle: TText.tOnboardingSubTitle3),
            ],
          ),
        ],
      )
    );
  }
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key, required this.image, required this.title, required this.subtitle,
  });

  final String image, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            width: THelperFunctions.screenWidth(context) * 0.8,
            height: THelperFunctions.screenHeight(context) * 0.6,
            image: AssetImage(image),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: TSizes.spaceBtwItems),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}