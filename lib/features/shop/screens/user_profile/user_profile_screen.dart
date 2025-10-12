import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/features/shop/screens/user_profile/widgets/user_header_section.dart';
import 'package:haybuy_client/features/shop/screens/user_profile/widgets/user_reviews_section.dart';
import 'package:haybuy_client/features/shop/screens/user_profile/widgets/user_products_section.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Seller Profile'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Header Section (Profile Image + Info)
              const UserHeaderSection(),
              const SizedBox(height: Sizes.spaceBtwSections),

              // User Reviews Section (Show 1 review + See more button)
              const UserReviewsSection(),
              const SizedBox(height: Sizes.spaceBtwSections),

              // User Products Section (All products by this user)
              const UserProductsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
