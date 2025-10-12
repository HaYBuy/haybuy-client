class ApiConstants {
  // Base URL - อัพเดท URL นี้ให้ตรงกับ Backend ของคุณ
  static const String baseUrl =
      'http://10.0.2.2:8000'; // สำหรับ Android Emulator
  // static const String baseUrl = 'http://localhost:8000'; // สำหรับ iOS Simulator
  // static const String baseUrl = 'http://YOUR_IP:8000'; // สำหรับ device จริง

  // API Version
  static const String apiVersion = '/v1';

  // Auth Endpoints
  static const String login = '$apiVersion/auth/login';
  static const String register = '$apiVersion/auth/register';
  static const String token = '$apiVersion/auth/token';

  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Timeout
  static const Duration timeout = Duration(seconds: 30);
}
