import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:haybuy_client/common/widgets/list_tiles/settings_menu_tile.dart';
import 'package:haybuy_client/common/widgets/list_tiles/user_profile_tile.dart';
import 'package:haybuy_client/common/widgets/texts/section_heading.dart';
import 'package:haybuy_client/features/personalization/controllers/user_controller.dart';
import 'package:haybuy_client/features/personalization/screens/address/address.dart';
import 'package:haybuy_client/features/personalization/screens/profile/profile.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  CustomAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context).textTheme.headlineMedium!.apply(
                        color: ConstColors.white,
                      ),
                    ),
                  ),

                  UserProfileTile(
                    onPressed: () => Get.to(() => ProfileScreen()),
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  SectionHeading(title: 'Account Settings'),
                  SizedBox(height: Sizes.spaceBtwItems),

                  SettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Addresses',
                    subTitle: 'Set shopping delivery address',
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: 'My Cart',
                    subTitle: 'Add, remove products and move to checkout',
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: 'My Orders',
                    subTitle: 'In-Progress and Completed orders',
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.bank,
                    title: 'Bank Account',
                    subTitle: 'Withdraw balance to registered bank account',
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: 'My Coupons',
                    subTitle: 'List of all the discount coupons',
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subTitle: 'Set any kind of notification messages',
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Security',
                    subTitle: 'Manage data usage and connected accounts',
                    onTap: () {},
                  ),

                  const SizedBox(height: Sizes.spaceBtwSections),

                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => controller.logout(),
                      child: const Text('Log Out'),
                    ),
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems),

                  // Delete Account Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => controller.deleteAccount(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        foregroundColor: Colors.red,
                      ),
                      child: const Text('Delete Account'),
                    ),
                  ),

                  const SizedBox(height: Sizes.spaceBtwItems * 2.5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
