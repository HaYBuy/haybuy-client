import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/images/circular_image.dart';
import 'package:haybuy_client/features/personalization/controllers/user_controller.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:iconsax/iconsax.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();

    return Obx(() {
      final user = controller.user.value;
      final isLoading = controller.isLoading.value;

      // Show loading state
      if (isLoading) {
        return ListTile(
          leading: const CircularProgressIndicator(
            color: ConstColors.white,
            strokeWidth: 2,
          ),
          title: Text(
            'Loading...',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: ConstColors.textWhite),
          ),
          subtitle: Text(
            'Please wait',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.apply(color: ConstColors.textWhite),
          ),
        );
      }

      // Show user data or default
      return ListTile(
        leading: Obx(
          () => CircularImage(
            image: controller.profileImageUrl.value.isEmpty
                ? Images.user
                : controller.profileImageUrl.value,
            width: 50,
            height: 50,
            padding: 0,
            isNetworkImage: controller.profileImageUrl.value.isNotEmpty,
          ),
        ),
        title: Text(
          user?.fullName ?? 'Guest User',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.apply(color: ConstColors.textWhite),
        ),
        subtitle: Text(
          user?.email ?? 'guest@haybuy.com',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.apply(color: ConstColors.textWhite),
        ),
        trailing: IconButton(
          onPressed: onPressed,
          icon: const Icon(Iconsax.edit, color: ConstColors.white),
        ),
        onTap: onPressed,
      );
    });
  }
}
