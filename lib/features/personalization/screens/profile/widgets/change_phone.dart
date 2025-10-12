import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/features/personalization/controllers/user_controller.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/popups/loaders.dart';
import 'package:iconsax/iconsax.dart';

class ChangePhoneScreen extends StatelessWidget {
  const ChangePhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final formKey = GlobalKey<FormState>();
    final phoneController = TextEditingController(
      text: controller.userProfile.value?.phone ?? '',
    );

    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Change Phone Number'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Instructions
                Text(
                  'Your phone number will be used for account verification and important notifications.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: Sizes.spaceBtwSections),

                // Phone Field
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.length < 9) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Iconsax.call),
                    hintText: '+66-123456789',
                  ),
                ),
                const SizedBox(height: Sizes.spaceBtwSections),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        await controller.updateProfile(
                          phone: phoneController.text.trim(),
                        );
                        Get.back();
                        Loaders.successSnackBar(
                          title: 'Success',
                          message: 'Phone number updated successfully',
                        );
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
