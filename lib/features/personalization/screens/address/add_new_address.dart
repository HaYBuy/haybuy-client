import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/features/personalization/controllers/user_controller.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/popups/loaders.dart';
import 'package:haybuy_client/utils/validators/validation.dart';
import 'package:iconsax/iconsax.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<UserController>();

  late TextEditingController phoneController;
  late TextEditingController addressLine1Controller;
  late TextEditingController addressLine2Controller;
  late TextEditingController districtController;
  late TextEditingController provinceController;
  late TextEditingController postalCodeController;

  @override
  void initState() {
    super.initState();
    final profile = controller.userProfile.value;

    phoneController = TextEditingController(text: profile?.phone ?? '');
    addressLine1Controller = TextEditingController(
      text: profile?.addressLine1 ?? '',
    );
    addressLine2Controller = TextEditingController(
      text: profile?.addressLine2 ?? '',
    );
    districtController = TextEditingController(text: profile?.district ?? '');
    provinceController = TextEditingController(text: profile?.province ?? '');
    postalCodeController = TextEditingController(
      text: profile?.postalCode ?? '',
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    addressLine1Controller.dispose();
    addressLine2Controller.dispose();
    districtController.dispose();
    provinceController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  Future<void> saveAddress() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      await controller.updateProfile(
        phone: phoneController.text.trim(),
        addressLine1: addressLine1Controller.text.trim(),
        addressLine2: addressLine2Controller.text.trim().isEmpty
            ? null
            : addressLine2Controller.text.trim(),
        district: districtController.text.trim(),
        province: provinceController.text.trim(),
        postalCode: postalCodeController.text.trim(),
      );

      Loaders.successSnackBar(
        title: 'Success',
        message: 'Address updated successfully',
      );

      Get.back();
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to update address: $e',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = controller.userProfile.value;
    final hasAddress =
        profile?.addressLine1 != null && profile!.addressLine1!.isNotEmpty;

    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(hasAddress ? 'Edit Address' : 'Add Address'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(
                  'Contact Information',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),

                TextFormField(
                  controller: phoneController,
                  validator: (value) => TValidator.validatePhoneNumber(value),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.call),
                    labelText: 'Phone Number',
                    hintText: '0812345678',
                  ),
                  keyboardType: TextInputType.phone,
                ),

                const SizedBox(height: Sizes.spaceBtwSections),
                Text(
                  'Address Details',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),

                TextFormField(
                  controller: addressLine1Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.building),
                    labelText: 'Address Line 1',
                    hintText: 'House number, street name',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),

                TextFormField(
                  controller: addressLine2Controller,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.building_4),
                    labelText: 'Address Line 2 (Optional)',
                    hintText: 'Apartment, building, floor',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: districtController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.map_1),
                          labelText: 'District',
                          hintText: 'Amphoe',
                        ),
                      ),
                    ),
                    const SizedBox(width: Sizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: postalCodeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          if (value.length != 5) {
                            return 'Invalid';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Postal Code',
                          hintText: '95110',
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),

                TextFormField(
                  controller: provinceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter province';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.location),
                    labelText: 'Province',
                    hintText: 'Changwat',
                  ),
                ),

                const SizedBox(height: Sizes.defaultSpace),

                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : saveAddress,
                      child: controller.isLoading.value
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              hasAddress ? 'Update Address' : 'Save Address',
                            ),
                    ),
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
