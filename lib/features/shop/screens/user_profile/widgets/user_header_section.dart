import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/images/circular_image.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';
import 'package:iconsax/iconsax.dart';

/// Widget สำหรับแสดงข้อมูลหลักของ User (รูปโปรไฟล์, ชื่อ, รายละเอียด)
class UserHeaderSection extends StatelessWidget {
  const UserHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.all(Sizes.md),
      decoration: BoxDecoration(
        color: dark ? ConstColors.dark : ConstColors.lightGrey,
        borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
      ),
      child: Column(
        children: [
          // Profile Image and Basic Info
          Row(
            children: [
              // Profile Picture
              const CircularImage(
                image: Images.user,
                width: 80,
                height: 80,
                padding: 0,
              ),
              const SizedBox(width: Sizes.spaceBtwItems),

              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Setsiri Aun',
                      style: Theme.of(context).textTheme.headlineSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Sizes.xs),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.verify5,
                          color: ConstColors.primary,
                          size: 16,
                        ),
                        const SizedBox(width: Sizes.xs),
                        Text(
                          'Verified Seller',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: Sizes.xs),
                    Row(
                      children: [
                        const Icon(
                          Iconsax.location,
                          size: 16,
                          color: ConstColors.darkGrey,
                        ),
                        const SizedBox(width: Sizes.xs),
                        Text(
                          'Bangkok, Thailand',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: Sizes.spaceBtwItems),

          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                context,
                icon: Iconsax.box,
                label: 'Products',
                value: '24',
              ),
              Container(
                height: 40,
                width: 1,
                color: dark ? ConstColors.darkGrey : ConstColors.grey,
              ),
              _buildStatItem(
                context,
                icon: Iconsax.star1,
                label: 'Rating',
                value: '4.5',
              ),
              Container(
                height: 40,
                width: 1,
                color: dark ? ConstColors.darkGrey : ConstColors.grey,
              ),
              _buildStatItem(
                context,
                icon: Iconsax.people,
                label: 'Followers',
                value: '1.2K',
              ),
            ],
          ),
          const SizedBox(height: Sizes.spaceBtwItems),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Iconsax.message),
                  label: const Text('Message'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.sm),
                  ),
                ),
              ),
              const SizedBox(width: Sizes.spaceBtwItems),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Iconsax.heart),
                  label: const Text('Follow'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.sm),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 20, color: ConstColors.primary),
        const SizedBox(height: Sizes.xs),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
