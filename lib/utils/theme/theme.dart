import 'package:flutter/material.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/theme/custom_themes/app_theme.dart';
import 'package:haybuy_client/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:haybuy_client/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:haybuy_client/utils/theme/custom_themes/chip_theme.dart';
import 'package:haybuy_client/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:haybuy_client/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:haybuy_client/utils/theme/custom_themes/text_field_theme.dart';
import 'package:haybuy_client/utils/theme/custom_themes/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: ConstColors.primary, // Mint green primary
    colorScheme: ColorScheme.light(
      primary: ConstColors.primary,
      secondary: ConstColors.secondary,
      surface: ConstColors.lightBackground,
      error: ConstColors.error,
    ),
    textTheme: CustomTextTheme.lightTextTheme,
    chipTheme: CustomChipTheme.lightChipTheme,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    checkboxTheme: CustomCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: TextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: ConstColors.primary, // Mint green primary
    colorScheme: ColorScheme.dark(
      primary: ConstColors.primary,
      secondary: ConstColors.secondary,
      surface: ConstColors.darkBackground,
      error: ConstColors.error,
    ),
    textTheme: CustomTextTheme.darkTextTheme,
    chipTheme: CustomChipTheme.darkChipTheme,
    scaffoldBackgroundColor: ConstColors.darkBackground,
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    checkboxTheme: CustomCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TextFormFieldTheme.darkInputDecorationTheme,
  );
}
