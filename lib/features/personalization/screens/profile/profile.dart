import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/common/widgets/images/circular_image.dart';
import 'package:haybuy_client/common/widgets/texts/section_heading.dart';
import 'package:haybuy_client/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(showBackArrow: true, title: Text('Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const CircularImage(
                      image: Images.user,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Change Profile Picture'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems),
              const SectionHeading(
                title: "Profile Information",
                showActionButton: false,
              ),
              const SizedBox(height: Sizes.spaceBtwItems),

              ProfileMenu(
                title: 'Name',
                value: 'Adithya Reddy',
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Username',
                value: 'AdithyaReddy',
                onPressed: () {},
              ),

              const SizedBox(height: Sizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems),

              const SectionHeading(
                title: 'Personal Information',
                showActionButton: false,
              ),
              const SizedBox(height: Sizes.spaceBtwItems),

              ProfileMenu(
                title: 'User ID',
                value: '456789',
                icon: Iconsax.copy,
                onPressed: () {},
              ),

              ProfileMenu(
                title: 'E-mail',
                value: 'AdithyaReddy@email.com',
                onPressed: () {},
              ),

              ProfileMenu(
                title: 'Phone Number',
                value: '+66-123456789',
                onPressed: () {},
              ),
              ProfileMenu(title: 'Gender', value: 'Male', onPressed: () {}),
              ProfileMenu(
                title: 'Date of Birth',
                value: '10 Oct 2000',
                onPressed: () {},
              ),
              const Divider(),
              const SizedBox(height: Sizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
