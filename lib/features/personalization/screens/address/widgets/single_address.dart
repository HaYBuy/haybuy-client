import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';
import 'package:iconsax/iconsax.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return RoundedContainer(
      showBorder: true,
      padding: const EdgeInsets.all(Sizes.md),
      width: double.infinity,
      backgroundColor: selectedAddress
          ? ConstColors.primary.withValues(alpha: 0.5)
          : Colors.transparent,
      borderColor: selectedAddress
          ? Colors.transparent
          : dark
          ? ConstColors.darkGrey
          : ConstColors.grey,
      margin: const EdgeInsets.only(bottom: Sizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(
              selectedAddress ? Iconsax.tick_circle : null,
              color: selectedAddress
                  ? dark
                        ? ConstColors.lightGrey
                        : ConstColors.dark
                  : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jane Doe',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: Sizes.sm / 2),
              const Text(
                '+66 1234 56789',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: Sizes.sm / 2),
              const Text(
                '111/01, Paitong, Betong, Yala, 95110',
                softWrap: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
