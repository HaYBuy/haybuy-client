import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('ออกจากระบบ'),
          content: const Text('คุณต้องการออกจากระบบหรือไม่?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text(
                'ออกจากระบบ',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );

      // If user cancelled
      if (confirmed != true) return;

      // Show loader
      FullScreenLoader.openLoadingDialog('กำลังออกจากระบบ...', '');

      // Logout
      await _authRepository.logout();

      logger.i('User logged out successfully');

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show success message
      Loaders.successSnackBar(
        title: 'ออกจากระบบสำเร็จ',
        message: 'แล้วพบกันใหม่!',
      );

      // Redirect to Login Screen
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(
        title: 'เกิดข้อผิดพลาด',
        message: 'ไม่สามารถออกจากระบบได้ กรุณาลองใหม่อีกครั้ง',
      );
      logger.e('Logout error: $e');
    }
  }

  /// Delete Account
  Future<void> deleteAccount() async {
    try {
      // Show confirmation dialog
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('ลบบัญชี'),
          content: const Text(
            'คุณแน่ใจหรือไม่ที่จะลบบัญชี?\n\n'
            '⚠️ ข้อมูลทั้งหมดจะถูกลบอย่างถาวร:\n'
            '• ข้อมูลส่วนตัว\n'
            '• ประวัติการสั่งซื้อ\n'
            '• รายการโปรด\n'
            '• ที่อยู่จัดส่ง\n\n'
            'การดำเนินการนี้ไม่สามารถย้อนกลับได้',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('ยกเลิก'),
            ),
            TextButton(
              onPressed: () => Get.back(result: true),
              child: const Text(
                'ลบบัญชี',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );

      // If user cancelled
      if (confirmed != true) return;

      // Show second confirmation for safety
      final doubleConfirmed = await Get.dialog<bool>(
        AlertDialog(
          title: const Text(
            'ยืนยันการลบบัญชีอีกครั้ง',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text(
            'นี่คือการยืนยันครั้งสุดท้าย\n\n'
            'คุณแน่ใจหรือไม่ว่าต้องการลบบัญชีถาวร?',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('ยกเลิก'),
            ),
            ElevatedButton(
              onPressed: () => Get.back(result: true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('ยืนยันการลบบัญชี'),
            ),
          ],
        ),
      );

      // If user cancelled second confirmation
      if (doubleConfirmed != true) return;

      // Show loader
      FullScreenLoader.openLoadingDialog('กำลังลบบัญชี...', '');

      // Call API to delete account
      await _authRepository.deleteAccount();

      // Clear local data
      await _authRepository.clearAuth();

      logger.i('Account deleted successfully');

      // Remove Loader
      FullScreenLoader.stopLoading();

      // Show success message
      Loaders.successSnackBar(
        title: 'ลบบัญชีสำเร็จ',
        message: 'บัญชีของคุณถูกลบเรียบร้อยแล้ว',
      );

      // Redirect to Login Screen
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenLoader.stopLoading();

      String errorMessage = 'ไม่สามารถลบบัญชีได้';

      if (e.toString().contains('401')) {
        errorMessage = 'กรุณาเข้าสู่ระบบใหม่';
      } else if (e.toString().contains('404')) {
        errorMessage = 'ไม่พบบัญชีผู้ใช้';
      } else if (e.toString().contains('Connection')) {
        errorMessage =
            'ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ได้\nกรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต';
      }

      Loaders.errorSnackBar(title: 'เกิดข้อผิดพลาด', message: errorMessage);
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
