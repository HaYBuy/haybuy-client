import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:haybuy_client/common/widgets/products/cart/coupon_widget.dart';
import 'package:haybuy_client/common/widgets/success_screen/success_screen.dart';
import 'package:haybuy_client/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:haybuy_client/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:haybuy_client/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:haybuy_client/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:haybuy_client/navigation_menu.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(title: Text('Order Review', style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              // Item in cart
              const CartItems(showAddRemoveButtons: false),
              const SizedBox(height: Sizes.spaceBtwSections),

              // Coupon Code
              CouponCode(),
              const SizedBox(height: Sizes.spaceBtwSections),

              // Billing Details
              RoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(Sizes.md),
                backgroundColor: dark ? ConstColors.black : ConstColors.white,
                child: Column(
                  children: [
                    // Price
                    BillingAmountSection(),
                    const SizedBox(height: Sizes.spaceBtwItems),

                    // Divider
                    const Divider(),
                    const SizedBox(height: Sizes.spaceBtwItems),

                    // Payment Method
                    const BillingPaymentSection(),
                    const SizedBox(height: Sizes.spaceBtwItems),

                    // Address
                    BillingAddressSection(),
                    const SizedBox(height: Sizes.spaceBtwItems),
                  ],
                )
              )
            ],
          ),
        ),
      ),

      // Checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(
            () => SuccessScreen(
              image: Images.successfulPayment, 
              title: 'Payment Success!', 
              subTitle: 'Your order will be delivered soon.', 
              onPressed: () => Get.offAll(() => const NavigationMenu()),
            ),
          ),
          child: Text('checkout 1,509฿')),
      ),
    );
  }
}
