import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class CustomRatingBarIndicator extends StatelessWidget {
  const CustomRatingBarIndicator({
    super.key, required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(itemBuilder: (_, __) => Icon(Iconsax.star1, color: ConstColors.primary),
      itemSize: 20,
      rating: rating,
      unratedColor: ConstColors.grey,
    );
  }
}