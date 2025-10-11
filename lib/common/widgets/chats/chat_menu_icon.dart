import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/features/shop/screens/chat/chat.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class ChatCounterIcon extends StatelessWidget {
  const ChatCounterIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
  });

  final VoidCallback onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: () => Get.to(() => const ChatScreen()), icon: Icon(Iconsax.message, color: iconColor)),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: ConstColors.black,
              borderRadius: BorderRadius.circular(100)
            ),
            child: Center(
              child: Text('2', style: Theme.of(context).textTheme.labelLarge!.apply(color: ConstColors.white, fontSizeFactor: 0.8),),
            ),
          ),
        ),
      ],
    );
  }
}