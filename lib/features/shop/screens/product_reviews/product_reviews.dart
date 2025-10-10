import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/device/device_utility.dart';

import '../../../../utils/constants/colors.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Product Reviews'), showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('This is where the product reviews will be displayed.'),
              SizedBox(height: Sizes.spaceBtwItems),

              Row(
                children: [
                  Expanded(flex: 3, child: Text('4.8', style: Theme.of(context).textTheme.displayLarge)),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(flex: 1, child: Text('5', style: Theme.of(context).textTheme.bodyMedium)),
                            Expanded(
                              flex: 11,
                              child: SizedBox(
                                width: DeviceUtils.getScreenWidth(context) * 0.8,
                                child: LinearProgressIndicator(
                                  value: 0.5,
                                  minHeight: 11,
                                  backgroundColor: ConstColors.grey,
                                  borderRadius: BorderRadius.circular(7),
                                  valueColor: const AlwaysStoppedAnimation(ConstColors.primary),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}