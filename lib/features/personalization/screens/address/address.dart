import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/features/personalization/controllers/user_controller.dart';
import 'package:haybuy_client/features/personalization/screens/address/add_new_address.dart';
import 'package:haybuy_client/features/personalization/screens/address/widgets/single_address.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'My Address',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = controller.userProfile.value;
        final hasAddress =
            profile?.addressLine1 != null && profile!.addressLine1!.isNotEmpty;

        if (!hasAddress) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.location_slash,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  'No Address Set',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Add your address to continue',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => Get.to(() => const AddNewAddressScreen()),
                  icon: const Icon(Iconsax.add),
                  label: const Text('Add Address'),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              SingleAddress(
                profile: profile,
                onEdit: () => Get.to(() => const AddNewAddressScreen()),
              ),
            ],
          ),
        );
      }),
    );
  }
}
