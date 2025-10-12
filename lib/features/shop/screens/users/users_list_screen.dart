import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/common/widgets/images/circular_image.dart';
import 'package:haybuy_client/features/shop/controllers/users_controller.dart';
import 'package:haybuy_client/features/shop/screens/users/user_profile_screen.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';
import 'package:iconsax/iconsax.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UsersController());
    final dark = HelperFunctions.isDarkMode(context);
    final currentUserId =
        controller.currentUserId; // Assuming this is provided by the controller

    return Scaffold(
      appBar: const CustomAppBar(title: Text('All Users'), showBackArrow: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final filteredUsers = controller.users
            .where((user) => user.id != currentUserId)
            .toList();

        if (filteredUsers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.people, size: 64, color: Colors.grey.shade400),
                const SizedBox(height: 16),
                Text(
                  'No Users Found',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'There are no users available',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: controller.refreshUsers,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.refreshUsers,
          child: ListView.separated(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            itemCount: filteredUsers.length,
            separatorBuilder: (context, index) =>
                const SizedBox(height: Sizes.spaceBtwItems),
            itemBuilder: (context, index) {
              final user = filteredUsers[index];
              return InkWell(
                onTap: () {
                  Get.to(
                    () => UserProfileScreen(userId: user.id.toString()),
                    transition: Transition.rightToLeft,
                  );
                },
                borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
                child: Container(
                  padding: const EdgeInsets.all(Sizes.md),
                  decoration: BoxDecoration(
                    color: dark ? ConstColors.dark : ConstColors.lightGrey,
                    borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
                    border: Border.all(
                      color: dark
                          ? ConstColors.darkGrey.withOpacity(0.3)
                          : ConstColors.grey.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Profile Picture
                      const CircularImage(
                        image: Images.user,
                        width: 60,
                        height: 60,
                        padding: 0,
                      ),
                      const SizedBox(width: Sizes.spaceBtwItems),

                      // User Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.fullName,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Iconsax.user,
                                  size: 14,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    '@${user.username}',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey.shade600),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  Iconsax.sms,
                                  size: 14,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    user.email,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey.shade600),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            if (user.isActive) ...[
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.verify5,
                                    size: 14,
                                    color: Colors.green.shade600,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Active',
                                    style: TextStyle(
                                      color: Colors.green.shade600,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Arrow Icon
                      Icon(
                        Iconsax.arrow_right_3,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
