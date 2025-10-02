import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/images/circular_image.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:iconsax/iconsax.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircularImage(
        image: Images.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(
        'Adithya Reddy',
        style: Theme.of(
          context,
        ).textTheme.headlineSmall!.apply(color: ConstColors.textWhite),
      ),
      subtitle: Text(
        'AdithyaReddy@gmail.com',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.apply(color: ConstColors.textWhite),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Iconsax.edit, color: ConstColors.white),
      ),
    );
  }
}
