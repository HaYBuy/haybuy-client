import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/features/authentication/controllers/signup_controller.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/constants/text_strings.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';

class TermsAndConditionsCheckbox extends StatelessWidget {
  const TermsAndConditionsCheckbox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = HelperFunctions.isDarkMode(context);

    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(
            () => Checkbox(
              value: controller.privacyPolicy.value,
              onChanged: (value) =>
                  controller.privacyPolicy.value = value ?? false,
            ),
          ),
        ),
        const SizedBox(width: Sizes.spaceBtwItems),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '${Texts.iAgreeTo} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: Texts.privacyPolicy,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? ConstColors.white : ConstColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark
                        ? ConstColors.white
                        : ConstColors.primary,
                  ),
                ),
                TextSpan(
                  text: ' ${Texts.and} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: Texts.termsOfUse,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                    color: dark ? ConstColors.white : ConstColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: dark
                        ? ConstColors.white
                        : ConstColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
