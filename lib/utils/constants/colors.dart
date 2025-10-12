import 'package:flutter/material.dart';

class ConstColors {
  // App theme colors - Based on the mint green design from the image
  static const Color primary = Color(0xFF55C39B); // Main mint green
  static const Color primaryVariant = Color(0xFF4BAE8C); // Darker mint green
  static const Color secondary = Color(0xFF2D3748); // Dark gray for contrast
  static const Color secondaryLight = Color(0xFF4A5568); // Lighter dark gray
  static const Color primaryBackground = Color(
    0xFF9BF0D6,
  ); // Light mint background
  static const Color secondaryBackground = Color(0xFFE6FFFA); // Very light mint
  static const Color accent = Color(0xFF3ECAA0); // Bright mint accent

  // Dashboard Specific Colors
  static const Color dashboardAppbarBackground = Color(
    0xFF55C39B,
  ); // Mint green for app bar

  // Text colors
  static const Color textPrimary = Color(
    0xFF2D3748,
  ); // Dark gray for primary text
  static const Color textSecondary = Color(
    0xFF4A5568,
  ); // Medium gray for secondary text
  static const Color textDarkPrimary = Color(0xFFFFFFFF); // White for dark mode
  static const Color textDarkSecondary = Color(
    0xFFE2E8F0,
  ); // Light gray for dark mode
  static const Color textWhite = Colors.white;

  static const Color disabledTextLight = Color(
    0xFFA0AEC0,
  ); // Light disabled text
  static const Color disabledBackgroundLight = Color(
    0xFFF7FAFC,
  ); // Light disabled background

  static const Color disabledTextDark = Color(0xFF718096); // Dark disabled text
  static const Color disabledBackgroundDark = Color(
    0xFF2D3748,
  ); // Dark disabled background

  // Background colors
  static const Color lightBackground = Color(0xFFFFFFFF); // Pure white
  static const Color darkBackground = Color(
    0xFF1A202C,
  ); // Dark navy for dark mode

  // Background Container colors
  static const Color lightContainer = Color(0xFFF7FAFC); // Very light gray
  static const Color darkContainer = Color(0xFF2D3748); // Dark gray container
  static const Color cardBackgroundColor = Color(
    0xFFE6FFFA,
  ); // Light mint for cards

  // Button colors
  static const Color buttonPrimary = primary; // Mint green buttons
  static const Color buttonSecondary = secondary; // Dark gray buttons
  static const Color buttonDisabled = disabledBackgroundLight;

  // -- Social Button Colors
  static const Color googleBackgroundColor = Color(
    0xFFE6FFFA,
  ); // Light mint for Google
  static const Color googleForegroundColor = Color(
    0xFF319795,
  ); // Teal for Google text
  static const Color facebookBackgroundColor = Color(0xFF1877F2);

  // -- ON-BOARDING COLORS
  static const Color onBoardingPage1Color = Color(0xFFFFFFFF); // White
  static const Color onBoardingPage2Color = Color(0xFFE6FFFA); // Light mint
  static const Color onBoardingPage3Color = Color(0xFF9BF0D6); // Medium mint

  // Icon colors
  static const Color iconPrimaryLight = Color(
    0xFF2D3748,
  ); // Dark gray for light mode
  static const Color iconSecondaryLight = Color(
    0xFF718096,
  ); // Medium gray for light mode
  static const Color iconPrimaryDark = Color(0xFFFFFFFF); // White for dark mode
  static const Color iconSecondaryDark = Color(
    0xFFE2E8F0,
  ); // Light gray for dark mode

  // Border colors
  static const Color borderPrimary = primary; // Mint green borders
  static const Color borderSecondary = secondary; // Dark gray borders
  static const Color borderLight = Color(0xFFE2E8F0); // Light gray borders
  static const Color borderDark = Color(0xFF4A5568); // Dark gray borders

  // Error and validation colors
  static const Color error = Color(0xFFE53E3E); // Red for errors
  static const Color success = Color(0xFF38A169); // Green for success
  static const Color warning = Color(0xFFD69E2E); // Yellow for warnings
  static const Color info = Color(0xFF3182CE); // Blue for info

  // Neutral Shades
  static const Color black = Color(
    0xFF1A202C,
  ); // Dark navy instead of pure black
  static const Color teal90 = Color(0xFF234E52); // Dark teal
  static const Color teal80 = Color(0xFF2C7A7B); // Medium teal
  static const Color teal20 = Color(0xFF9DECF9); // Light teal
  static const Color dark = Color(0xFF2D3748); // Dark gray
  static const Color darkerGrey = Color(0xFF4A5568); // Darker gray
  static const Color darkGrey = Color(0xFF718096); // Dark gray
  static const Color grey = Color(0xFFA0AEC0); // Medium gray
  static const Color grey10 = Color(0xFFF7FAFC); // Very light gray
  static const Color softGrey = Color(0xFFEDF2F7); // Soft gray
  static const Color lightGrey = Color(0xFFF7FAFC); // Light gray
  static const Color white = Color(0xFFFFFFFF); // Pure white
  static const Color red = Color(0xFFE53E3E); // Consistent red
}
