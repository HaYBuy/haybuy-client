import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class AllProducts extends StatelessWidget {
  const AllProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Text(' Products'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              //Dropdown
              DropdownButtonFormField(
                decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
                onChanged: (value) {},
                items: [],
              )
            ],
          )
        )
      )
    );
  }
}