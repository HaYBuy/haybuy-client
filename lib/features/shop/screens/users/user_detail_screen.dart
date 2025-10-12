import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/common/widgets/images/circular_image.dart';
import 'package:haybuy_client/data/repositories/user_repository.dart';
import 'package:haybuy_client/features/authentication/models/auth_models.dart';
import 'package:haybuy_client/features/shop/models/user_profile_model.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';
import 'package:haybuy_client/utils/popups/loaders.dart';
import 'package:iconsax/iconsax.dart';

class UserDetailScreen extends StatefulWidget {
  final int userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  final _userRepository = UserRepository();
  final RxBool isLoading = true.obs;
  Rx<UserResponse?> user = Rx<UserResponse?>(null);
  Rx<UserProfileModel?> userProfile = Rx<UserProfileModel?>(null);

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;

      // Fetch user basic info
      final fetchedUser = await _userRepository.getUserById(widget.userId);
      user.value = fetchedUser;

      // Try to fetch user profile (might not exist)
      try {
        final fetchedProfile = await _userRepository.getMyProfile();
        if (fetchedProfile.userId == widget.userId) {
          userProfile.value = fetchedProfile;
        }
      } catch (e) {
        // Profile might not exist, that's okay
        print('No profile found for user ${widget.userId}');
      }
    } catch (e) {
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to load user data: $e',
      );
      Get.back();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('User Profile'),
        showBackArrow: true,
      ),
      body: Obx(() {
        if (isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final userData = user.value;
        if (userData == null) {
          return const Center(child: Text('User not found'));
        }

        final profile = userProfile.value;

        return RefreshIndicator(
          onRefresh: fetchUserData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Container(
                    padding: const EdgeInsets.all(Sizes.md),
                    decoration: BoxDecoration(
                      color: dark ? ConstColors.dark : ConstColors.lightGrey,
                      borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
                    ),
                    child: Column(
                      children: [
                        // Profile Picture and Name
                        Row(
                          children: [
                            const CircularImage(
                              image: Images.user,
                              width: 80,
                              height: 80,
                              padding: 0,
                            ),
                            const SizedBox(width: Sizes.spaceBtwItems),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData.fullName,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '@${userData.username}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.grey.shade600),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        userData.isActive
                                            ? Iconsax.verify5
                                            : Iconsax.close_circle,
                                        size: 16,
                                        color: userData.isActive
                                            ? Colors.green.shade600
                                            : Colors.red.shade600,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        userData.isActive
                                            ? 'Active'
                                            : 'Inactive',
                                        style: TextStyle(
                                          color: userData.isActive
                                              ? Colors.green.shade600
                                              : Colors.red.shade600,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: Sizes.spaceBtwSections),

                  // Basic Information Section
                  Text(
                    'Basic Information',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems),

                  _buildInfoCard(
                    dark: dark,
                    icon: Iconsax.user,
                    title: 'User ID',
                    value: userData.id.toString(),
                    onTap: () {
                      Clipboard.setData(
                        ClipboardData(text: userData.id.toString()),
                      );
                      Loaders.successSnackBar(
                        title: 'Copied',
                        message: 'User ID copied to clipboard',
                      );
                    },
                    showCopyIcon: true,
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems),

                  _buildInfoCard(
                    dark: dark,
                    icon: Iconsax.sms,
                    title: 'Email',
                    value: userData.email,
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems),

                  _buildInfoCard(
                    dark: dark,
                    icon: Iconsax.calendar,
                    title: 'Member Since',
                    value: _formatDate(userData.createdAt),
                  ),

                  // Profile Information (if available)
                  if (profile != null) ...[
                    const SizedBox(height: Sizes.spaceBtwSections),
                    Text(
                      'Contact Information',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Sizes.spaceBtwItems),

                    if (profile.phone != null && profile.phone!.isNotEmpty)
                      _buildInfoCard(
                        dark: dark,
                        icon: Iconsax.call,
                        title: 'Phone',
                        value: profile.phone!,
                      ),

                    if (profile.addressLine1 != null &&
                        profile.addressLine1!.isNotEmpty) ...[
                      const SizedBox(height: Sizes.spaceBtwItems),
                      _buildInfoCard(
                        dark: dark,
                        icon: Iconsax.location,
                        title: 'Address',
                        value: _buildAddressString(profile),
                        isMultiline: true,
                      ),
                    ],

                    if (profile.locationVerified) ...[
                      const SizedBox(height: Sizes.spaceBtwItems),
                      Container(
                        padding: const EdgeInsets.all(Sizes.sm),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(Sizes.sm),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.verify5,
                              color: Colors.green.shade700,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Location Verified',
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildInfoCard({
    required bool dark,
    required IconData icon,
    required String title,
    required String value,
    VoidCallback? onTap,
    bool showCopyIcon = false,
    bool isMultiline = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Sizes.cardRadiusMd),
      child: Container(
        padding: const EdgeInsets.all(Sizes.md),
        decoration: BoxDecoration(
          color: dark
              ? ConstColors.dark.withOpacity(0.5)
              : ConstColors.lightGrey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(Sizes.cardRadiusMd),
          border: Border.all(
            color: dark
                ? ConstColors.darkGrey.withOpacity(0.3)
                : ConstColors.grey.withOpacity(0.3),
          ),
        ),
        child: Row(
          crossAxisAlignment: isMultiline
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            Icon(icon, color: ConstColors.primary, size: 24),
            const SizedBox(width: Sizes.spaceBtwItems),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: isMultiline,
                    overflow: isMultiline
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (showCopyIcon)
              Icon(Iconsax.copy, color: Colors.grey.shade600, size: 20),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _buildAddressString(UserProfileModel profile) {
    final parts = <String>[];

    if (profile.addressLine1 != null && profile.addressLine1!.isNotEmpty) {
      parts.add(profile.addressLine1!);
    }
    if (profile.addressLine2 != null && profile.addressLine2!.isNotEmpty) {
      parts.add(profile.addressLine2!);
    }
    if (profile.district != null && profile.district!.isNotEmpty) {
      parts.add(profile.district!);
    }
    if (profile.province != null && profile.province!.isNotEmpty) {
      parts.add(profile.province!);
    }
    if (profile.postalCode != null && profile.postalCode!.isNotEmpty) {
      parts.add(profile.postalCode!);
    }

    return parts.join(', ');
  }
}
