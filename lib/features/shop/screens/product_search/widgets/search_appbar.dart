import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/features/shop/screens/product_search/widgets/search_bar.dart';

import '../../../../../utils/constants/sizes.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      actions: [
        Column(
          children: [
            // Search Bar
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 64),
                child: CustomSearchBar(),
              ),
            ),
            SizedBox(height: Sizes.spaceBtwItems),

            // Search History

          ],
        )
      ],
      showBackArrow: true,
    );
  }
}