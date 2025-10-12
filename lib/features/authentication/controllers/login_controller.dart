import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haybuy_client/data/repositories/authentication_repository.dart';
import 'package:haybuy_client/data/services/api/api_service.dart';
import 'package:haybuy_client/navigation_menu.dart';
import 'package:haybuy_client/utils/popups/full_screen_loader.dart';
import 'package:haybuy_client/utils/popups/loaders.dart';
import 'package:logger/logger.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final logger = Logger();

  /// Text controllers
  final email = TextEditingController();
  final password = TextEditingController();

  /// Form key for validation
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  /// Repository
  final AuthenticationRepository _authRepository = AuthenticationRepository();

  @override
  void onInit() {
    // เช็คว่ามี Remember Me ไหม
    final savedEmail = localStorage.read('REMEMBER_ME_EMAIL');
    final savedPassword = localStorage.read('REMEMBER_ME_PASSWORD');

    if (savedEmail != null && savedEmail.isNotEmpty) {
      email.text = savedEmail;
      rememberMe.value = true;
    }

    if (savedPassword != null && savedPassword.isNotEmpty) {
      password.text = savedPassword;
    }

    super.onInit();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  /// Email and Password SignIn
  Future<void> emailAndPasswordSignIn() async {
    try {
      // Show loader with simple loading indicator
      FullScreenLoader.openLoadingDialog(
        'Signing in to your account',
        '', // Animation path (optional)
      );

      // Check Internet Connectivity
      // final isConnected = await NetworkManager.instance.isConnected();
      // if (!isConnected) {
      //   FullScreenLoader.stopLoading();
      //   return;
      // }

      // Form Validation
      if (!loginFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      } else {
        localStorage.remove('REMEMBER_ME_EMAIL');
        localStorage.remove('REMEMBER_ME_PASSWORD');
      }

      // Login
      final response = await _authRepository.login(
        email.text.trim(),
        password.text.trim(),
      );

      logger.i('Login successful: ${response.accessToken}');

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show success message
      Loaders.successSnackBar(
        title: 'Login Successful',
        message: 'Welcome back!',
      );

      // Redirect to home
      Get.offAll(() => const NavigationMenu());
    } on ApiException catch (e) {
      FullScreenLoader.stopLoading();

      String errorMessage = 'Login failed';
      if (e.message.toLowerCase().contains('invalid')) {
        errorMessage = 'Invalid username or password';
      } else if (e.statusCode == 400) {
        errorMessage = 'Invalid username or password';
      } else if (e.statusCode == 422) {
        errorMessage = 'Please fill in all required fields';
      } else if (e.statusCode == null) {
        errorMessage =
            'Unable to connect to server\nPlease check your internet connection';
      }

      Loaders.errorSnackBar(title: 'Error', message: errorMessage);

      logger.e('Login error: ${e.message}');
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'An unexpected error occurred. Please try again.',
      );
      logger.e('Unexpected error during login: $e');
    }
  }

  /// Google SignIn Authentication (สำหรับใช้ภายหลัง)
  Future<void> googleSignIn() async {
    try {
      // Show loader
      FullScreenLoader.openLoadingDialog(
        'กำลังเข้าสู่ระบบด้วย Google...',
        'assets/images/loading_animation.json',
      );

      // Implement Google Sign In

      FullScreenLoader.stopLoading();

      Loaders.warningSnackBar(
        title: 'Under Development',
        message: 'This feature is currently under development',
      );
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
