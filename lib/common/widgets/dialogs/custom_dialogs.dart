import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haybuy_client/utils/constants/colors.dart';
import 'package:haybuy_client/utils/constants/sizes.dart';

class CustomDialogs {
  /// Show confirmation dialog with custom styling
  static Future<bool?> showConfirmationDialog({
    required String title,
    required String message,
    String? confirmText,
    String? cancelText,
    Color? confirmColor,
    bool isDanger = false,
  }) {
    return Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusLg),
        ),
        child: Container(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          decoration: BoxDecoration(
            color: Get.isDarkMode ? ConstColors.dark : ConstColors.white,
            borderRadius: BorderRadius.circular(Sizes.borderRadiusLg),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                title,
                style: Theme.of(Get.context!).textTheme.headlineSmall?.copyWith(
                  color: isDanger ? Colors.red : null,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwItems),

              // Message
              Text(message, style: Theme.of(Get.context!).textTheme.bodyMedium),
              const SizedBox(height: Sizes.spaceBtwSections),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Cancel Button
                  TextButton(
                    onPressed: () => Get.back(result: false),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.md,
                        vertical: Sizes.sm,
                      ),
                    ),
                    child: Text(
                      cancelText ?? 'Cancel',
                      style: TextStyle(
                        color: Get.isDarkMode
                            ? ConstColors.white
                            : ConstColors.dark,
                      ),
                    ),
                  ),
                  const SizedBox(width: Sizes.sm),

                  // Confirm Button
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () => Get.back(result: true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            confirmColor ??
                            (isDanger ? Colors.red : ConstColors.primary),
                        foregroundColor: ConstColors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.md,
                          vertical: Sizes.sm,
                        ),
                      ),
                      child: Text(
                        confirmText ?? 'Confirm',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// Show warning dialog for dangerous actions
  static Future<bool?> showWarningDialog({
    required String title,
    required String message,
    required List<String> warningPoints,
    String? confirmText,
    String? cancelText,
  }) {
    return Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadiusLg),
        ),
        child: Container(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          decoration: BoxDecoration(
            color: Get.isDarkMode ? ConstColors.dark : ConstColors.white,
            borderRadius: BorderRadius.circular(Sizes.borderRadiusLg),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title with warning icon
              Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 28,
                  ),
                  const SizedBox(width: Sizes.sm),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(Get.context!).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Sizes.spaceBtwItems),

              // Message
              Text(message, style: Theme.of(Get.context!).textTheme.bodyMedium),
              const SizedBox(height: Sizes.sm),

              // Warning Points
              Container(
                padding: const EdgeInsets.all(Sizes.sm),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusMd),
                  border: Border.all(
                    color: Colors.red.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: warningPoints
                      .map(
                        (point) => Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.xs,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '• ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  point,
                                  style: Theme.of(
                                    Get.context!,
                                  ).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: Sizes.sm),

              // Cannot be undone message
              Text(
                'This action cannot be undone.',
                style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwSections),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Cancel Button
                  TextButton(
                    onPressed: () => Get.back(result: false),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.md,
                        vertical: Sizes.sm,
                      ),
                    ),
                    child: Text(
                      cancelText ?? 'Cancel',
                      style: TextStyle(
                        color: Get.isDarkMode
                            ? ConstColors.white
                            : ConstColors.dark,
                      ),
                    ),
                  ),
                  const SizedBox(width: Sizes.sm),

                  // Confirm Button (Danger)
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () => Get.back(result: true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: ConstColors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.md,
                          vertical: Sizes.sm,
                        ),
                      ),
                      child: Text(
                        confirmText ?? 'Confirm',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
