import 'package:flutter/material.dart';
import 'package:haybuy_client/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:haybuy_client/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:haybuy_client/features/shop/screens/product_details/widgets/rating_and_share.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
// import 'package:haybuy_client/utils/helpers/helper_function.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Product Images
            ProductImageSlider(),

            /// Product details
            Padding(
              padding: EdgeInsets.only(
                right: Sizes.defaultSpace,
                left: Sizes.defaultSpace,
                bottom: Sizes.defaultSpace,
              ),
              child: Column(
                children: [
                  /// Rating & Share
                  RatingAndShare(),

                  /// Price, Title, Stock, &Brand
                  ProductMetaData(),

                  /// Attributes
                  /// Checkout button
                  /// Description
                  /// Reviews
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}