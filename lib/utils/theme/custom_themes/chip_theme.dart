import 'package:flutter/material.dart';
import 'package:haybuy_client/utils/constants/colors.dart';

class CustomChipTheme {
  CustomChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: ConstColors.disabledBackgroundLight,
    labelStyle: TextStyle(color: ConstColors.textPrimary),
    selectedColor: ConstColors.primary, // Mint green when selected
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: Colors.white,
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: ConstColors.disabledBackgroundDark,
    labelStyle: TextStyle(color: ConstColors.textDarkPrimary),
    selectedColor: ConstColors.primary, // Mint green when selected
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: Colors.white,
  );
}
