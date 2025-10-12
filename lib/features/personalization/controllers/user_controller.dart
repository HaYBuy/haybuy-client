import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haybuy_client/common/widgets/dialogs/custom_dialogs.dart';
import 'package:haybuy_client/data/repositories/authentication_repository.dart';
import 'package:haybuy_client/data/repositories/user_repository.dart';
import 'package:haybuy_client/features/authentication/models/auth_models.dart';
import 'package:haybuy_client/features/authentication/screens/login/login.dart';
import 'package:haybuy_client/features/shop/models/user_profile_model.dart';
import 'package:haybuy_client/utils/popups/full_screen_loader.dart';
import 'package:haybuy_client/utils/popups/loaders.dart';
import 'package:logger/logger.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final logger = Logger();
  final localStorage = GetStorage();
  final AuthenticationRepository _authRepository = AuthenticationRepository();
  final UserRepository _userRepository = UserRepository();

  // Observable variables
  final Rx<UserResponse?> user = Rx<UserResponse?>(null);
  final Rx<UserProfileModel?> userProfile = Rx<UserProfileModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString profileImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Load user data when controller is initialized if user is authenticated
    if (_authRepository.isAuthenticated()) {
      fetchUserData();
    }
  }

  /// Fetch user data and profile
  Future<void> fetchUserData() async {
    try {
      // Check if user is authenticated first
      if (!_authRepository.isAuthenticated()) {
        logger.w('User not authenticated, skipping fetch');
        return;
      }

      isLoading.value = true;

      logger.i('=== Starting user data fetch ===');

      // Add small delay to ensure token is saved
      await Future.delayed(const Duration(milliseconds: 300));

      // Fetch user basic info
      logger.i('Fetching user basic info...');
      final userData = await _userRepository.getMe();
      user.value = userData;
      logger.i('User data fetched: ${userData.username}');

      // Fetch user profile - handle case where profile doesn't exist yet
      try {
        logger.i('Fetching user profile...');
        final profileData = await _userRepository.getMyProfile();
        userProfile.value = profileData;
        logger.i('Profile data fetched: User ID ${profileData.userId}');
      } catch (profileError) {
        if (profileError.toString().contains('404')) {
          logger.w(
            'Profile not found - User may need to complete profile setup',
          );
          // Profile doesn't exist yet, that's okay for new users
          userProfile.value = null;
        } else {
          rethrow; // Re-throw other errors
        }
      }

      logger.i('=== User data fetch complete ===');
    } catch (e, stackTrace) {
      logger.e('Failed to fetch user data: $e');
      logger.e('Stack trace: $stackTrace');

      // Check if it's an authentication error
      if (e.toString().contains('401') ||
          e.toString().contains('token') ||
          e.toString().contains('No authentication token found') ||
          e.toString().contains('Could not validate credentials')) {
        logger.e('Authentication error detected - Token expired or invalid');

        // Clear the token
        await _authRepository.logout();

        Loaders.warningSnackBar(
          title: 'Session Expired',
          message: 'Please log in again to continue',
        );
        // Redirect to login after 1.5 seconds
        await Future.delayed(const Duration(milliseconds: 1500));
        Get.offAll(() => const LoginScreen());
      } else if (e.toString().contains('404')) {
        logger.e('User not found');
        Loaders.errorSnackBar(
          title: 'User Not Found',
          message: 'User account does not exist',
        );
      } else if (e.toString().contains('Connection') ||
          e.toString().contains('Failed host lookup')) {
        logger.e('Connection error');
        Loaders.errorSnackBar(
          title: 'Connection Error',
          message: 'Cannot connect to server. Please check your internet.',
        );
      } else {
        logger.e('Unknown error occurred');
        Loaders.errorSnackBar(
          title: 'Error',
          message: 'Failed to load user data. Please try again.',
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Update user profile
  Future<void> updateProfile({
    String? phone,
    String? addressLine1,
    String? addressLine2,
    String? district,
    String? province,
    String? postalCode,
    double? latitude,
    double? longitude,
  }) async {
    try {
      FullScreenLoader.openLoadingDialog('Updating profile...', '');

      final updatedProfile = await _userRepository.updateProfile(
        phone: phone,
        addressLine1: addressLine1,
        addressLine2: addressLine2,
        district: district,
        province: province,
        postalCode: postalCode,
        latitude: latitude,
        longitude: longitude,
      );

      userProfile.value = updatedProfile;

      FullScreenLoader.stopLoading();
      Loaders.successSnackBar(
        title: 'Success',
        message: 'Profile updated successfully',
      );

      logger.i('Profile updated successfully');
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to update profile. Please try again.',
      );
      logger.e('Update profile error: $e');
    }
  }

  /// Upload profile picture
  Future<void> uploadProfilePicture(String imagePath) async {
    try {
      FullScreenLoader.openLoadingDialog('Uploading picture...', '');

      final imageUrl = await _userRepository.uploadProfilePicture(imagePath);
      profileImageUrl.value = imageUrl;

      FullScreenLoader.stopLoading();
      Loaders.successSnackBar(
        title: 'Success',
        message: 'Profile picture updated successfully',
      );

      logger.i('Profile picture uploaded successfully');
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to upload picture. Please try again.',
      );
      logger.e('Upload profile picture error: $e');
    }
  }

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
