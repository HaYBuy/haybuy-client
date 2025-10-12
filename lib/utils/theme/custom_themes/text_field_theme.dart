import 'package:flutter/material.dart';
import 'package:haybuy_client/utils/constants/colors.dart';

class TextFormFieldTheme {
  TextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: ConstColors.iconSecondaryLight,
    suffixIconColor: ConstColors.iconSecondaryLight,

    labelStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: ConstColors.textSecondary,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: ConstColors.textSecondary,
    ),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: ConstColors.primary, // Mint green when focused
    ),

    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: ConstColors.borderLight),
    ),

    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: ConstColors.borderLight),
    ),

    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1,
        color: ConstColors.primary,
      ), // Mint green when focused
    ),

    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: ConstColors.error),
    ),

    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 2, color: ConstColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: ConstColors.iconSecondaryDark,
    suffixIconColor: ConstColors.iconSecondaryDark,

    labelStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: ConstColors.textDarkSecondary,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: ConstColors.textDarkSecondary,
    ),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
      fontSize: 14,
      color: ConstColors.primary, // Mint green when focused
    ),

    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: ConstColors.borderDark),
    ),

    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: ConstColors.borderDark),
    ),

    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(
        width: 1,
        color: ConstColors.primary,
      ), // Mint green when focused
    ),

    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 1, color: ConstColors.error),
    ),

    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(width: 2, color: ConstColors.warning),
    ),
  );
}
