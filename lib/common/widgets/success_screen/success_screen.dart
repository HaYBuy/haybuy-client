import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/styles/spacing_styles.dart';
import 'package:haybuy_client/features/authentication/screens/login/login.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/constants/text_strings.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              Image(
                image: AssetImage(Images.deliveredEmailIllustration),
                width: HelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: Sizes.spaceBtwSections),

              ///Title & Subtitle
              Text(
                Texts.yourAccountCreatedTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
              Text(
                Texts.yourAccountCreatedSubTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Sizes.spaceBtwSections),

              ///Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(()=> const LoginScreen()),
                  child: const Text(Texts.textContinue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
