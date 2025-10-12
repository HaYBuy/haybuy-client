import 'package:flutter/material.dart';
import 'package:haybuy_client/utils/constants/colors.dart';

class CustomOutlinedButtonTheme {
  CustomOutlinedButtonTheme._();

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: ConstColors.primary, // Mint green text
      side: const BorderSide(color: ConstColors.primary), // Mint green border
      textStyle: const TextStyle(
        fontSize: 16,
        color: ConstColors.primary,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );

  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: ConstColors.primary, // Mint green text for dark mode
      side: const BorderSide(color: ConstColors.primary), // Mint green border
      textStyle: const TextStyle(
        fontSize: 16,
        color: ConstColors.primary,
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
