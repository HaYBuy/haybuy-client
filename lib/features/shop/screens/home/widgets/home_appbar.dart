import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/common/widgets/chats/chat_menu_icon.dart';
import 'package:haybuy_client/common/widgets/products/cart/cart_menu_icon.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Texts.homeAppbarTitle, style: Theme.of(context).textTheme.labelMedium!.apply(color: ConstColors.grey)),
          Text(Texts.homeAppbarSubTitle, style: Theme.of(context).textTheme.headlineSmall!.apply(color: ConstColors.white)),
        ],
      ),
      actions: [
        ChatCounterIcon(onPressed: () {  }, iconColor: ConstColors.white,),
        CartCounterIcon(onPressed: () {  }, iconColor: ConstColors.white,)
      ],
    );
  }
}
