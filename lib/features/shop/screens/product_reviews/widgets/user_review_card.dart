import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:haybuy_client/common/widgets/products/rating/rating_indicator.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';
import 'package:readmore/readmore.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: AssetImage(Images.user)),
                const SizedBox(width: Sizes.spaceBtwItems),
                Text('Setsiri Aun', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems),

        // Review Text
        Row(
          children: [
            CustomRatingBarIndicator(rating: 4),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text('01 Jan, 2025', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems),
        const ReadMoreText(
          'This is a great product! I really enjoyed using it and it exceeded my expectations. The quality is top-notch and the design is sleek and modern. I would highly recommend this to anyone looking for a reliable and stylish option.',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimCollapsedText: ' Show more',
          trimExpandedText: ' Show less',
          moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ConstColors.primary),
          lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ConstColors.primary),
        ),
        const SizedBox(height: Sizes.spaceBtwItems),

        // Comments Replies
        RoundedContainer(
          backgroundColor: dark ? ConstColors.darkGrey : ConstColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.xs),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Joe's Shoes", style: Theme.of(context).textTheme.titleMedium),
                    Text('01 Jan, 2025', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(height: Sizes.spaceBtwItems),
                const ReadMoreText(
                  'This is a great product! I really enjoyed using it and it exceeded my expectations. The quality is top-notch and the design is sleek and modern. I would highly recommend this to anyone looking for a reliable and stylish option.',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' Show more',
                  trimExpandedText: ' Show less',
                  moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ConstColors.primary),
                  lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ConstColors.primary),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Sizes.spaceBtwSections),
      ],
    );
  }
}
