import 'package:flutter/material.dart';
import 'package:haybuy_client/common/widgets/appbar/appbar.dart';

import '../../../../utils/constants/sizes.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Text('Setsiri', style: Theme.of(context).textTheme.headlineSmall), showBackArrow: true),
      body: Column(
        children: [
          Divider(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  // Chat messages
                  Text('data')
                ],
              ),
            ),
          ),
        ],
      ),

      // Checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: ElevatedButton(onPressed: () { }, child: Text('Send Message')),
      ),
    );
  }
}