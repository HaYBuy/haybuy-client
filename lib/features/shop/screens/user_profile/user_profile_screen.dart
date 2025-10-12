import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/features/shop/screens/user_profile/widgets/user_header_section.dart';
import 'package:haybuy_client/features/shop/screens/user_profile/widgets/user_reviews_section.dart';
import 'package:haybuy_client/features/shop/screens/user_profile/widgets/user_products_section.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';

class UserProfileScreen extends StatelessWidget {
  final String userId;

  const UserProfileScreen({super.key, required this.userId});

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
              UserHeaderSection(userId: userId),
              const SizedBox(height: Sizes.spaceBtwSections),

              // User Reviews Section (Show 1 review + See more button)
              UserReviewsSection(userId: userId),
              const SizedBox(height: Sizes.spaceBtwSections),

              // User Products Section (All products by this user)
              UserProductsSection(userId: userId),
            ],
          ),
        ),
      ),
    );
  }
}
