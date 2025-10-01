import 'package:flutter/material.dart';
import 'package:haybuy_client/common/styles/spacing_styles.dart';
import 'package:haybuy_client/utils/constants/image_strings.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';
import 'package:haybuy_client/utils/constants/text_strings.dart';
import 'package:haybuy_client/utils/helpers/helper_function.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    height: 150,
                    image: AssetImage(dark? Images.darkAppLogo : Images.lightAppLogo ),
                  ),
                  Text(Texts.loginTitle, style: Theme.of(context).textTheme.headlineMedium),
                  Text(Texts.loginSubTitle, style: Theme.of(context).textTheme.headlineMedium),

                  const SizedBox(height: Sizes.defaultSpace),
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
