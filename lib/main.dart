import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haybuy_client/features/authentication/screens/onboarding/onboarding.dart';
import 'package:haybuy_client/utils/theme/theme.dart';

void main() async {
  await GetStorage.init();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const OnboardingScreen(),
    );
  }
}