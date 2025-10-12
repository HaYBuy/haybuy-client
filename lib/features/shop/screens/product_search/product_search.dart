import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/layouts/grid_layout.dart';
import 'package:haybuy_client/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:haybuy_client/common/widgets/texts/section_heading.dart';
import 'package:haybuy_client/features/shop/screens/product_search/widgets/search_appbar.dart';

import '../../../../utils/constants/sizes.dart';

class ProductSearchScreen extends StatelessWidget {
  const ProductSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchAppBar(),
            SizedBox(height: Sizes.spaceBtwItems),
            Divider(),
            Padding(
              padding: EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  SectionHeading(title: 'You may also like', showActionButton: false),
                  const SizedBox(height: Sizes.spaceBtwItems),
                  GridLayout(
                    itemCount: 8,
                    itemBuilder: (_, index) => const ProductCardVertical()
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}