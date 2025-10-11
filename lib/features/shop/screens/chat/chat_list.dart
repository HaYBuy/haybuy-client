import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';
import 'package:haybuy_client/common/widgets/chats/chat_item.dart';
import 'package:haybuy_client/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:haybuy_client/common/widgets/layouts/list_layout.dart';

import '../../../../utils/constants/sizes.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Text('Chat', style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              // Search bar
              SearchContainer(text: 'Search chats . . .', padding: EdgeInsets.zero),
              SizedBox(height: Sizes.spaceBtwSections),

              // List of chats
              ListLayout(
                itemCount: 2,
                itemBuilder: (_, index) => const ChatItem())
            ],
          ),
        ),
      ),
    );
  }
}