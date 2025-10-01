import 'package:flutter/material.dart';
import 'package:haybuy_client/common/styles/spacing_styles.dart';
import 'package:haybuy_client/features/authentication/screens/login/widgets/login_form.dart';
import 'package:haybuy_client/features/authentication/screens/login/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: SpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LoginHeader(),
              LoginForm(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Flexible(
              //       child: Divider(
              //         color: dark ? ConstColors.darkGrey : ConstColors.grey,
              //         thickness: 0.5,
              //         indent: 60,
              //         endIndent: 5,
              //       ),
              //     ),
              //     Flexible(
              //       child: Divider(
              //         color: dark ? ConstColors.darkGrey : ConstColors.grey,
              //         thickness: 0.5,
              //         indent: 5,
              //         endIndent: 60,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}