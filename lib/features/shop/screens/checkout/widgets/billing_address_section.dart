import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/texts/section_heading.dart';

import '../../../../../utils/constants/sizes.dart';

class BillingAddressSection extends StatelessWidget {
  const BillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(title: 'Shipping Address', buttonTitle: 'Change', onPressed: () {}),
        Text('Setsiri Aun', style: Theme.of(context).textTheme.bodyLarge),
        
        // Phone
        Row(
          children: [
            const Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text('+66 1234 56789', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 2),

        // Address
        Row(
          children: [
            const Icon(Icons.location_city, color: Colors.grey, size: 16),
            const SizedBox(width: Sizes.spaceBtwItems),
            Flexible(child: Text('123, Moo 5, Tambon Bang Phli Yai, Amphoe Bang Phli, Samut Prakan 10540', style: Theme.of(context).textTheme.bodyMedium, softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis)),
          ],
        ),
      ],
    );
  }
}
