import 'package:flutter/material.dart';
import 'package:haybuy_client/utils/constants/colors.dart';

class CustomElevatedButtonTheme {
  CustomElevatedButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: ConstColors.primary, // Mint green button
      disabledForegroundColor: ConstColors.disabledTextLight,
      disabledBackgroundColor: ConstColors.disabledBackgroundLight,
      side: const BorderSide(color: ConstColors.primary),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: ConstColors.primary, // Mint green button for dark mode
      disabledForegroundColor: ConstColors.disabledTextDark,
      disabledBackgroundColor: ConstColors.disabledBackgroundDark,
      side: const BorderSide(color: ConstColors.primary),
      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
