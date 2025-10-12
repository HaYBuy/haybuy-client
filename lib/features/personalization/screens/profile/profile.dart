import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/common/widgets/images/circular_image.dart';
import 'package:haybuy_client/common/widgets/texts/section_heading.dart';
import 'package:haybuy_client/data/repositories/authentication_repository.dart';
import 'package:haybuy_client/features/authentication/screens/login/login.dart';
import 'package:haybuy_client/features/personalization/controllers/user_controller.dart';
import 'package:haybuy_client/features/personalization/screens/profile/widgets/change_name.dart';
import 'package:haybuy_client/features/personalization/screens/profile/widgets/change_phone.dart';
import 'package:haybuy_client/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/popups/loaders.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final authRepo = AuthenticationRepository();

    return Scaffold(
      appBar: const CustomAppBar(showBackArrow: true, title: Text('Profile')),
      body: Obx(() {
        // Check if user is authenticated
        if (!authRepo.isAuthenticated()) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.login, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                const Text(
                  'Not Logged In',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please log in to view your profile',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.offAll(() => const LoginScreen());
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('Log In'),
                ),
              ],
            ),
          );
        }

        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.user.value;
        final profile = controller.userProfile.value;

        if (user == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.person_off_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Failed to load user data',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please check your connection',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: controller.fetchUserData,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Get.offAll(() => const LoginScreen());
                  },
                  child: const Text('Back to Login'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.fetchUserData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  // Profile Picture Section
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Obx(
                          () => CircularImage(
                            image: controller.profileImageUrl.value.isEmpty
                                ? Images.user
                                : controller.profileImageUrl.value,
                            width: 80,
                            height: 80,
                            isNetworkImage:
                                controller.profileImageUrl.value.isNotEmpty,
                          ),
                        ),
                        TextButton(
                          onPressed: () => _showImageSourceDialog(context),
                          child: const Text('Change Profile Picture'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems / 2),
                  const Divider(),
                  const SizedBox(height: Sizes.spaceBtwItems),

                  // Profile Information Section
                  const SectionHeading(
                    title: "Profile Information",
                    showActionButton: false,
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems),

                  ProfileMenu(
                    title: 'Name',
                    value: user.fullName,
                    icon: Iconsax.edit,
                    onPressed: () => Get.to(() => const ChangeNameScreen()),
                  ),
                  ProfileMenu(
                    title: 'Username',
                    value: user.username,
                    icon: Iconsax.lock,
                    onPressed: () {},
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems),
                  const Divider(),
                  const SizedBox(height: Sizes.spaceBtwItems),

                  // Personal Information Section
                  const SectionHeading(
                    title: 'Personal Information',
                    showActionButton: false,
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems),

                  ProfileMenu(
                    title: 'User ID',
                    value: user.id.toString(),
                    icon: Iconsax.copy,
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: user.id.toString()),
                      );
                      Loaders.successSnackBar(
                        title: 'Copied',
                        message: 'User ID copied to clipboard',
                      );
                    },
                  ),

                  ProfileMenu(
                    title: 'E-mail',
                    value: user.email,
                    icon: Iconsax.lock,
                    onPressed: () {},
                  ),

                  ProfileMenu(
                    title: 'Phone Number',
                    value: profile?.phone ?? 'Not set',
                    icon: Iconsax.edit,
                    onPressed: () => Get.to(() => const ChangePhoneScreen()),
                  ),

                  if (profile?.addressLine1 != null) ...[
                    ProfileMenu(
                      title: 'Address',
                      value:
                          '${profile!.addressLine1}${profile.addressLine2 != null ? ', ${profile.addressLine2}' : ''}',
                      icon: Iconsax.lock,
                      onPressed: () {},
                    ),
                    ProfileMenu(
                      title: 'District',
                      value: profile.district ?? 'Not set',
                      icon: Iconsax.lock,
                      onPressed: () {},
                    ),
                    ProfileMenu(
                      title: 'Province',
                      value: profile.province ?? 'Not set',
                      icon: Iconsax.lock,
                      onPressed: () {},
                    ),
                    ProfileMenu(
                      title: 'Postal Code',
                      value: profile.postalCode ?? 'Not set',
                      icon: Iconsax.lock,
                      onPressed: () {},
                    ),
                  ],

                  const Divider(),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  Center(
                    child: TextButton(
                      onPressed: () => controller.deleteAccount(),
                      child: const Text(
                        'Close Account',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final controller = UserController.instance;
    final picker = ImagePicker();

    try {
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
      );

      if (image != null) {
        await controller.uploadProfilePicture(image.path);
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to pick image: $e',
      );
    }
  }
}
