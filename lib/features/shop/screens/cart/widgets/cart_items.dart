import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/products/cart/add_remove_button.dart';
import 'package:haybuy_client/common/widgets/products/cart/cart_item.dart';
import 'package:haybuy_client/common/widgets/texts/product_price_text.dart';

import '../../../../../utils/constants/sizes.dart';

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 2,
      separatorBuilder: (_, __) => const SizedBox(height: Sizes.spaceBtwSections),
      itemBuilder: (_, index) => Column(
        children: [
          const CartItem(),
          if (showAddRemoveButtons) const SizedBox(height: Sizes.spaceBtwItems),

          if (showAddRemoveButtons)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 70),
            
                    // Add-Remove Button
                    ProductQuantityWithAddRemoveButton(),
                  ],
                ),
                ProductPriceText(price: '1,499'),
              ],
            )
        ],
      ),
    );
  }
}