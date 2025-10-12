import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haybuy_client/data/repositories/authentication_repository.dart';
import 'package:haybuy_client/data/services/api/api_service.dart';
import 'package:haybuy_client/features/authentication/screens/signup/verify_email.dart';
import 'package:haybuy_client/utils/popups/full_screen_loader.dart';
import 'package:haybuy_client/utils/popups/loaders.dart';
import 'package:logger/logger.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  /// Variables
  final hidePassword = true.obs;
  final privacyPolicy = false.obs;
  final localStorage = GetStorage();
  final logger = Logger();

  /// Text controllers
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  /// Form key for validation
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  /// Repository
  final AuthenticationRepository _authRepository = AuthenticationRepository();

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    username.dispose();
    email.dispose();
    phoneNumber.dispose();
    password.dispose();
    super.onClose();
  }

  /// Signup
  Future<void> signup() async {
    try {
      // Show loader
      FullScreenLoader.openLoadingDialog('กำลังสร้างบัญชี...', '');

      // Check Internet Connectivity
      // final isConnected = await NetworkManager.instance.isConnected();
      // if (!isConnected) {
      //   FullScreenLoader.stopLoading();
      //   return;
      // }

      // Form Validation
      if (!signupFormKey.currentState!.validate()) {
        FullScreenLoader.stopLoading();
        return;
      }

      // Privacy Policy Check
      if (!privacyPolicy.value) {
        FullScreenLoader.stopLoading();
        Loaders.warningSnackBar(
          title: 'ยอมรับข้อกำหนด',
          message: 'กรุณายอมรับข้อกำหนดและเงื่อนไขการใช้งาน',
        );
        return;
      }

      // Register user
      final fullName = '${firstName.text.trim()} ${lastName.text.trim()}';

      final userResponse = await _authRepository.register(
        username: username.text.trim(),
        password: password.text.trim(),
        fullName: fullName,
        email: email.text.trim(),
      );

      logger.i('Registration successful: ${userResponse.username}');

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show success message
      Loaders.successSnackBar(
        title: 'ยินดีด้วย!',
        message: 'สร้างบัญชีสำเร็จแล้ว กรุณาเข้าสู่ระบบ',
      );

      // Move to Verify Email Screen (or Login Screen)
      Get.to(() => const VerifyEmailScreen());
    } on ApiException catch (e) {
      FullScreenLoader.stopLoading();

      String errorMessage = 'สร้างบัญชีไม่สำเร็จ';

      if (e.message.toLowerCase().contains('already exists')) {
        errorMessage = 'ชื่อผู้ใช้นี้ถูกใช้งานแล้ว กรุณาเลือกชื่อผู้ใช้อื่น';
      } else if (e.statusCode == 400) {
        errorMessage = e.message;
      } else if (e.statusCode == 422) {
        errorMessage = 'กรุณากรอกข้อมูลให้ถูกต้องและครบถ้วน';
      } else if (e.statusCode == null) {
        errorMessage =
            'ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้\nกรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต';
      }

      Loaders.errorSnackBar(title: 'เกิดข้อผิดพลาด', message: errorMessage);

      logger.e('Registration error: ${e.message}');
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(
        title: 'เกิดข้อผิดพลาด',
        message: 'เกิดข้อผิดพลาดที่ไม่คาดคิด กรุณาลองใหม่อีกครั้ง',
      );
      logger.e('Unexpected error during registration: $e');
    }
  }
}
