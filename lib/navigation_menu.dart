import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/features/personalization/screens/settings/settings.dart';
import 'package:haybuy_client/features/shop/screens/home/home.dart';
import 'package:haybuy_client/features/shop/screens/store/store.dart';
import 'package:haybuy_client/features/shop/screens/wishlist/wishlist.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      floatingActionButton: SizedBox(
        width: 70,  
        height: 70, 
        child: FloatingActionButton(
          onPressed: () {},
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 40),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: dark
              ? ConstColors.darkBackground
              : ConstColors.lightBackground,
          indicatorColor: dark
              ? ConstColors.primary.withValues(alpha: 0.2)
              : ConstColors.primary.withValues(alpha: 0.1),

          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
            NavigationDestination(
              icon: Icon(Iconsax.heart),
              label: 'Favorites',
            ),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screen[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screen = [
    const HomeScreen(),
    const StoreScreen(),
    const FavouriteScreen(),
    const SettingScreen(),
  ];
}
