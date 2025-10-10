import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:haybuy_client/common/widgets/texts/section_heading.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_function.dart';

class BillingPaymentSection extends StatelessWidget {
  const BillingPaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Column(
      children: [
        SectionHeading(title: 'Payment Method', buttonTitle: 'Change', onPressed: () {}),
        const SizedBox(height: Sizes.spaceBtwItems / 2),
        Row(
          children: [
            RoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? ConstColors.lightGrey : ConstColors.white,
              padding: const EdgeInsets.all(Sizes.sm),
              child: const Image(image: AssetImage(Images.mastercard), fit: BoxFit.contain),
            ),
            const SizedBox(width: Sizes.spaceBtwItems / 2),
            Text('Mastercard', style: Theme.of(context).textTheme.bodyLarge),
          ],
        )
      ],
    );
  }
}
