import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/rounded_container.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_function.dart';

class CouponCode extends StatelessWidget {
  const CouponCode({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    
    return RoundedContainer(
      showBorder: true,
      backgroundColor: dark ? ConstColors.dark : ConstColors.white,
      padding: const EdgeInsets.only(top: Sizes.sm, bottom: Sizes.sm, right: Sizes.sm, left: Sizes.md),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Promo Code',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ),
    
          //Button
          SizedBox(
            width: 80,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: dark ? ConstColors.white.withValues(alpha: 0.5) : ConstColors.dark.withValues(alpha: 0.5),
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
                side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
              ),
              child: const Text('Apply'),
            ),
          )
        ],
      ),
    );
  }
}