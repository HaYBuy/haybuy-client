import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/success_screen/success_screen.dart';
import 'package:haybuy_client/features/authentication/screens/login/login.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/constants/text_strings.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => const LoginScreen()),
            icon: const Icon(CupertinoIcons.clear),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              ///Image
              Image(
                image: const AssetImage(Images.deliveredEmailIllustration),
                width: HelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: Sizes.spaceBtwSections),

              ///Title & Subtitle
              Text(
                Texts.confirmEmail,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
              Text(
                'support@haybuy.com',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
              Text(
                Texts.confirmEmailSubTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: Sizes.spaceBtwSections),

              ///Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => SuccessScreen(
                    image: Images.successfullyRegisterAnimation,
                    title: Texts.yourAccountCreatedTitle,
                    subTitle: Texts.yourAccountCreatedSubTitle,
                    onPressed: () => Get.to(() => const LoginScreen()),
                  )),
                  child: const Text(Texts.textContinue),
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(Texts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
