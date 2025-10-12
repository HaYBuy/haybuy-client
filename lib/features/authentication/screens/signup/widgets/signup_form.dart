import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/features/authentication/controllers/signup_controller.dart';
import 'package:haybuy_client/features/authentication/screens/login/login.dart';
import 'package:haybuy_client/features/authentication/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/constants/text_strings.dart';
import 'package:haybuy_client/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Form(
      key: controller.signupFormKey,
      child: Column(
        children: [
          // First Name & Last Name
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      TValidator.validateEmptyText('Name', value),
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
                  controller: controller.lastName,
                  validator: (value) =>
                      TValidator.validateEmptyText('นามสกุล', value),
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

          // Username
          TextFormField(
            controller: controller.username,
            validator: (value) => TValidator.validateUsername(value),
            expands: false,
            decoration: const InputDecoration(
              labelText: Texts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),

          // Email
          TextFormField(
            controller: controller.email,
            validator: (value) => TValidator.validateEmail(value),
            decoration: const InputDecoration(
              labelText: Texts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),

          // Phone Number (Optional - ไม่ได้ส่งไป Backend)
          TextFormField(
            controller: controller.phoneNumber,
            decoration: const InputDecoration(
              labelText: Texts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: Sizes.spaceBtwInputFields),

          // Password
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) => TValidator.validatePassword(value),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                labelText: Texts.password,
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: () => controller.hidePassword.value =
                      !controller.hidePassword.value,
                  icon: Icon(
                    controller.hidePassword.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: Sizes.spaceBtwSections),

          // Terms & Conditions Checkbox
          TermsAndConditionsCheckbox(),

          const SizedBox(height: Sizes.spaceBtwSections),

          // Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.signup(),
              child: const Text(Texts.createAccount),
            ),
          ),

          const SizedBox(height: Sizes.spaceBtwItems),

          // Back to Login Button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Get.off(() => const LoginScreen()),
              child: const Text('Back to Login'),
            ),
          ),
        ],
      ),
    );
  }
}
