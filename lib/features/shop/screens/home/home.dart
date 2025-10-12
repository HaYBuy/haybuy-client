import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:haybuy_client/common/widgets/layouts/grid_layout.dart';
import 'package:haybuy_client/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:haybuy_client/common/widgets/texts/section_heading.dart';
import 'package:haybuy_client/features/shop/screens/all_products/all_products.dart';
import 'package:haybuy_client/features/shop/screens/home/widgets/announcement_slider.dart';
import 'package:haybuy_client/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:haybuy_client/features/shop/screens/home/widgets/home_categories.dart';
import 'package:haybuy_client/features/shop/screens/product_search/product_search.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../product_create/product_create.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            Get.to(() => const CreateProductScreen());
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 40),
        ),
      ),
      
      body: SingleChildScrollView(
        child: 
        Column(
          children: [ 
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  
                  // Appbar
                  HomeAppBar(),
                  SizedBox(height: Sizes.spaceBtwSections),

                  // Searchbar
                  SearchContainer(
                    text: 'Search for Products',
                    icon: Iconsax.search_normal,
                    onTap: () => Get.to(() => const ProductSearchScreen()),
                  ),
                  SizedBox(height: Sizes.spaceBtwSections),

                  // Categories
                  Padding(
                    padding: const EdgeInsets.only(left: Sizes.defaultSpace),
                    child: Column(
                      children: [
                        // Heading
                        SectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: ConstColors.white,
                        ),
                        SizedBox(height: Sizes.spaceBtwSections),

                        // List of Categories
                        HomeCategories(),
                      ],
                    ),
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  // Announcement Slider
                  AnnouncementSlider(
                    banners: [
                      Images.onboardingImage1,
                      Images.onboardingImage2,
                      Images.onboardingImage3,
                    ],
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections),

                  // Heading
                  SectionHeading(title: 'Following Products', onPressed: () => Get.to(() => const AllProducts())),
                  const SizedBox(height: Sizes.spaceBtwItems),

                  // Products Vertical List
                  GridLayout(
                    itemCount: 8,
                    itemBuilder: (_, index) => const ProductCardVertical(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
