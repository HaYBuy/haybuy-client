import 'package:flutter/material.dart';
import 'package:haybuy_client/utils/constants/colors.dart';

/// A widget for displaying an animated loading indicator with optional text and action button.
class AnimationLoaderWidget extends StatelessWidget {
  /// Default constructor for the AnimationLoaderWidget.
  ///
  /// Parameters:
  ///   - text: The text to be displayed below the animation.
  ///   - animation: The path to the Lottie animation file (optional, not used if empty).
  ///   - showAction: Whether to show an action button below the text.
  ///   - actionText: The text to be displayed on the action button.
  ///   - onActionPressed: Callback function to be executed when the action button is pressed.
  const AnimationLoaderWidget({
    super.key,
    required this.text,
    this.animation = '',
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Use CircularProgressIndicator instead of Lottie
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ConstColors.primary),
          ),
          const SizedBox(height: 24),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: ConstColors.dark,
                    ),
                    child: Text(
                      actionText!,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.apply(color: Colors.white),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
