import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:haybuy_client/features/shop/screens/checkout/checkout.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true,),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        
        // Items in cart
        child: CartItems(),
      ),

      // Checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: ElevatedButton(onPressed: () => Get.to(() => const CheckoutScreen()), child: Text('checkout 1,499฿')),
      ),
    );
  }
}
