import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';

/// A utility class for managing a full-screen loading dialog.
class FullScreenLoader {
  /// Open a full-screen loading dialog with a given text and animation.
  /// This method doesn't return anything.
  ///
  /// Parameters:
  ///   - text: The text to be displayed in the loading dialog.
  ///   - animation: The Lottie animation to be shown (optional, not used if empty).
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context:
          Get.overlayContext!, // Use Get.overlayContext for overlay dialogs
      barrierDismissible:
          false, // The dialog can't be dismissed by tapping outside it
      builder: (_) => PopScope(
        canPop: false, // Disable popping with the back button
        child: Container(
          color: Get.isDarkMode ? ConstColors.dark : ConstColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Modern Loading Indicator
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer circle
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          ConstColors.primary.withOpacity(0.3),
                        ),
                      ),
                    ),
                    // Inner circle
                    const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          ConstColors.primary,
                        ),
                      ),
                    ),
                    // Center icon
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 32,
                      color: ConstColors.primary,
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.spaceBtwSections),

                // Loading text with modern styling
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.defaultSpace,
                  ),
                  child: Column(
                    children: [
                      Text(
                        text,
                        style: Theme.of(Get.context!).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: Sizes.sm),
                      Text(
                        'Please wait...',
                        style: Theme.of(Get.context!).textTheme.bodySmall
                            ?.copyWith(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Stop the currently open loading dialog.
  /// This method doesn't return anything.
  static stopLoading() {
    Navigator.of(
      Get.overlayContext!,
    ).pop(); // Close the dialog using the Navigator
  }
}
