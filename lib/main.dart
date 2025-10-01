import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/features/authentication/screens/onboarding/onboarding.dart';
import 'package:haybuy_client/utils/theme/theme.dart';

void main() {

  

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const OnboardingScreen(),
    );
  }
}
