import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/features/personalization/screens/address/add_new_address.dart';
import 'package:haybuy_client/features/personalization/screens/address/widgets/single_address.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: Icon(Iconsax.add, color: ConstColors.white),
      ),
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(
          'Addresses',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(Sizes.defaultSpace),
        child: Column(children: [
            SingleAddress(selectedAddress: true),
            SingleAddress(selectedAddress: false),
            SingleAddress(selectedAddress: false),
            SingleAddress(selectedAddress: false),
        ],),
      ),
    );
  }
}
