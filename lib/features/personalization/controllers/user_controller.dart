import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haybuy_client/common/widgets/dialogs/custom_dialogs.dart';
import 'package:haybuy_client/data/repositories/authentication_repository.dart';
import 'package:haybuy_client/features/authentication/screens/login/login.dart';
import 'package:haybuy_client/utils/popups/full_screen_loader.dart';
import 'package:haybuy_client/utils/popups/loaders.dart';
import 'package:logger/logger.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final logger = Logger();
  final localStorage = GetStorage();
  final AuthenticationRepository _authRepository = AuthenticationRepository();

  /// Logout
  Future<void> logout() async {
    try {
      // Show confirmation dialog
      final confirmed = await CustomDialogs.showConfirmationDialog(
        title: 'Log Out',
        message: 'Are you sure you want to log out?',
        confirmText: 'Log Out',
        cancelText: 'Cancel',
        isDanger: true,
      );

      // If user cancelled
      if (confirmed != true) return;

      // Show loader
      FullScreenLoader.openLoadingDialog('Logging out...', '');

      // Logout (Clear token and local data)
      await _authRepository.logout();

      logger.i('User logged out successfully');

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show success message
      Loaders.successSnackBar(title: 'Logged Out', message: 'See you again!');

      // Redirect to Login Screen
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to log out. Please try again.',
      );
      logger.e('Logout error: $e');
    }
  }

  /// Delete Account
  Future<void> deleteAccount() async {
    try {
      // Show first warning dialog
      final confirmed = await CustomDialogs.showWarningDialog(
        title: 'Delete Account',
        message: 'Are you sure you want to delete your account?',
        warningPoints: [
          'Personal Information',
          'Order History',
          'Wishlist Items',
          'Saved Addresses',
        ],
        confirmText: 'Delete',
        cancelText: 'Cancel',
      );

      // If user cancelled
      if (confirmed != true) return;

      // Show second confirmation for safety
      final doubleConfirmed = await CustomDialogs.showConfirmationDialog(
        title: 'Final Confirmation',
        message:
            'This is your last chance.\n\nAre you absolutely sure you want to permanently delete your account?',
        confirmText: 'Yes, Delete My Account',
        cancelText: 'Cancel',
        confirmColor: Colors.red,
        isDanger: true,
      );

      // If user cancelled second confirmation
      if (doubleConfirmed != true) return;

      // Show loader
      FullScreenLoader.openLoadingDialog('Deleting account...', '');

      // Call API to delete account
      await _authRepository.deleteAccount();

      // Call logout to clear local data and token
      await _authRepository.logout();

      logger.i('Account deleted successfully');

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show success message
      Loaders.successSnackBar(
        title: 'Account Deleted',
        message: 'Your account has been successfully deleted.',
      );

      // Redirect to Login Screen
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();

      String errorMessage = 'Failed to delete account.';

      if (e.toString().contains('401')) {
        errorMessage = 'Please log in again.';
      } else if (e.toString().contains('404')) {
        errorMessage = 'User account not found.';
      } else if (e.toString().contains('Connection')) {
        errorMessage =
            'Unable to connect to server.\nPlease check your internet connection.';
      }

      Loaders.errorSnackBar(title: 'Error', message: errorMessage);
      logger.e('Delete account error: $e');
    }
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    return _authRepository.isAuthenticated();
  }

  /// Get user token
  String? getToken() {
    return _authRepository.getToken();
  }
}
