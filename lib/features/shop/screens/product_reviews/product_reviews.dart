import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/common/widgets/products/rating/rating_indicator.dart';
import 'package:haybuy_client/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:haybuy_client/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Rating & Reviews'), showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('This is where the product reviews will be displayed.'),
              SizedBox(height: Sizes.spaceBtwItems),

              // Overall Rating and Progress Indicators
              const OverallProductRating(),
              const CustomRatingBarIndicator(rating: 3.5),
              Text('12,345', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: Sizes.spaceBtwSections),

              // User Reviews List
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
