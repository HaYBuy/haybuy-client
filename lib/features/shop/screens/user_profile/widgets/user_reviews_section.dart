import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/texts/section_heading.dart';
import 'package:haybuy_client/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';

/// Widget สำหรับแสดง Reviews ของ User (แสดง 1 รายการ + ปุ่มดูเพิ่มเติม)
class UserReviewsSection extends StatelessWidget {
  final String userId;

  const UserReviewsSection({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Heading with See All button
        SectionHeading(
          title: 'Reviews',
          showActionButton: true,
          buttonTitle: 'See All',
          onPressed: () {
            // Navigate to all reviews page
            Get.to(() => const UserAllReviewsScreen());
          },
        ),
        const SizedBox(height: Sizes.spaceBtwItems),

        // Show only 1 review
        const UserReviewCard(),

        // Display user-specific reviews
        Text(
          'User Reviews for $userId',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        // Add more UI elements here
      ],
    );
  }
}

/// หน้าแสดง Reviews ทั้งหมดของ User
class UserAllReviewsScreen extends StatelessWidget {
  const UserAllReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Reviews')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              // Display multiple reviews
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
