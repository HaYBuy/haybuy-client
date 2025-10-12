import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/features/personalization/controllers/user_controller.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

class ChangeNameScreen extends StatelessWidget {
  const ChangeNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController(
      text: controller.user.value?.fullName ?? '',
    );

    return Scaffold(
      appBar: const CustomAppBar(
        showBackArrow: true,
        title: Text('Change Name'),
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
                  'Use real name for easy verification. This name will appear on several pages.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: Sizes.spaceBtwSections),

                // Name Field
                TextFormField(
                  controller: nameController,
                  validator: (value) =>
                      TValidator.validateEmptyText('Name', value),
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
                const SizedBox(height: Sizes.spaceBtwSections),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // TODO: Implement name update when backend endpoint is ready
                        // For now, just show success message
                        Get.back();
                        // Loaders.successSnackBar(
                        //   title: 'Success',
                        //   message: 'Name updated successfully',
                        // );
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
