import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:haybuy_client/features/shop/models/user_profile_model.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.profile, required this.onEdit});

  final UserProfileModel profile;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    // Build address string
    String addressText = '';
    if (profile.addressLine1 != null && profile.addressLine1!.isNotEmpty) {
      addressText = profile.addressLine1!;
    }
    if (profile.addressLine2 != null && profile.addressLine2!.isNotEmpty) {
      addressText += ', ${profile.addressLine2}';
    }
    if (profile.district != null && profile.district!.isNotEmpty) {
      addressText += ', ${profile.district}';
    }
    if (profile.province != null && profile.province!.isNotEmpty) {
      addressText += ', ${profile.province}';
    }
    if (profile.postalCode != null && profile.postalCode!.isNotEmpty) {
      addressText += ', ${profile.postalCode}';
    }

    return RoundedContainer(
      showBorder: true,
      padding: const EdgeInsets.all(Sizes.md),
      width: double.infinity,
      backgroundColor: ConstColors.primary.withOpacity(0.1),
      borderColor: ConstColors.primary.withOpacity(0.3),
      margin: const EdgeInsets.only(bottom: Sizes.spaceBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Iconsax.location5, color: ConstColors.primary, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Your Address',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Iconsax.edit, size: 20),
                tooltip: 'Edit Address',
              ),
            ],
          ),
          const SizedBox(height: Sizes.sm),
          if (profile.phone != null && profile.phone!.isNotEmpty) ...[
            Row(
              children: [
                Icon(Iconsax.call, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Text(
                  profile.phone!,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: Sizes.sm / 2),
          ],
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Iconsax.map, size: 16, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  addressText.isNotEmpty ? addressText : 'No address provided',
                  style: Theme.of(context).textTheme.bodyMedium,
                  softWrap: true,
                ),
              ),
            ],
          ),
          if (profile.locationVerified) ...[
            const SizedBox(height: Sizes.sm),
            Row(
              children: [
                Icon(Iconsax.verify5, size: 16, color: Colors.green.shade600),
                const SizedBox(width: 4),
                Text(
                  'Location Verified',
                  style: TextStyle(
                    color: Colors.green.shade600,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
