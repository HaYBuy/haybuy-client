import 'package:flutter/material.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/constants/text_strings.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';
import 'package:iconsax/iconsax.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Signup Screen')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              ///Tile
              Text(
                Texts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: Sizes.spaceBtwSections),

              ///Form
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            expands: false,
                            decoration: const InputDecoration(
                              labelText: Texts.firstName,
                              prefixIcon: Icon(Iconsax.user),
                            ),
                          ),
                        ),
                        const SizedBox(width: Sizes.spaceBtwInputFields),
                        Expanded(
                          child: TextFormField(
                            expands: false,
                            decoration: const InputDecoration(
                              labelText: Texts.lastName,
                              prefixIcon: Icon(Iconsax.user),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Sizes.spaceBtwInputFields),
                    TextFormField(
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: Texts.username,
                        prefixIcon: Icon(Iconsax.user_edit),
                      ),
                    ),
                    const SizedBox(height: Sizes.spaceBtwInputFields),

                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: Texts.email,
                        prefixIcon: Icon(Iconsax.user_edit),
                      ),
                    ),
                    const SizedBox(height: Sizes.spaceBtwInputFields),

                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: Texts.phoneNo,
                        prefixIcon: Icon(Iconsax.call),
                      ),
                    ),
                    const SizedBox(height: Sizes.spaceBtwInputFields),

                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: Texts.password,
                        prefixIcon: Icon(Iconsax.password_check),
                        suffixIcon: Icon(Iconsax.eye_slash),
                      ),
                    ),

                    const SizedBox(height: Sizes.spaceBtwSections),

                    Row(
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Checkbox(value: true, onChanged: (value) {}),
                        ),
                        const SizedBox(width: Sizes.spaceBtwItems),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${Texts.iAgreeTo} ',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: Texts.privacyPolicy,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .apply(
                                      color: dark
                                          ? ConstColors.white
                                          : ConstColors.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: dark
                                          ? ConstColors.white
                                          : ConstColors.primary,
                                    ),
                              ),
                              TextSpan(
                                text: ' ${Texts.and} ',
                                style: Theme.of(context).textTheme.bodySmall),
                              TextSpan(
                                text: Texts.termsOfUse,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .apply(
                                      color: dark
                                          ? ConstColors.white
                                          : ConstColors.primary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: dark
                                          ? ConstColors.white
                                          : ConstColors.primary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
