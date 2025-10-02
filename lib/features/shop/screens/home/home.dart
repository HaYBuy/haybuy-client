import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/search_ccontainer.dart';
import 'package:haybuy_client/common/widgets/texts/section_heading.dart';
import 'package:haybuy_client/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:haybuy_client/features/shop/screens/home/widgets/home_categories.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                  ),
                  SizedBox(height: Sizes.spaceBtwSections),

                  // Categories
                  Padding(
                    padding: const EdgeInsets.only(left: Sizes.defaultSpace),
                    child: Column(
                      children: [
                        // Heading
                        SectionHeading(title: 'Popular Categories', showActionButton: false, textColor: ConstColors.white,),
                        SizedBox(height: Sizes.spaceBtwSections),

                        // List of Categories
                        HomeCategories(),
                      ],
                    ),
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
