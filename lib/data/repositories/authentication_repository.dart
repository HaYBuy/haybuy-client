import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:haybuy_client/data/services/api/api_service.dart';
import 'package:haybuy_client/features/authentication/models/auth_models.dart';
import 'package:haybuy_client/utils/constants/api_constants.dart';

class AuthenticationRepository {
  final ApiService _apiService;
  final GetStorage _storage = GetStorage();
  final Logger _logger = Logger();

  // Storage keys
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  AuthenticationRepository({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  /// Login with username and password
  Future<LoginResponse> login(String username, String password) async {
    try {
      _logger.i('Attempting login for user: $username');

      final loginRequest = LoginRequest(username: username, password: password);

      final response = await _apiService.post(
        ApiConstants.login,
        body: loginRequest.toJson(),
      );

      final loginResponse = LoginResponse.fromJson(response);

      // Save token to local storage
      await saveToken(loginResponse.accessToken);

      _logger.i('Login successful');
      return loginResponse;
    } catch (e) {
      _logger.e('Login failed: $e');
      rethrow;
    }
  }

  /// Register a new user
  Future<UserResponse> register({
    required String username,
    required String password,
    required String fullName,
    required String email,
  }) async {
    try {
      _logger.i('Attempting registration for user: $username');

      final registerRequest = RegisterRequest(
        username: username,
        password: password,
        fullName: fullName,
        email: email,
      );

      final response = await _apiService.post(
        ApiConstants.register,
        body: registerRequest.toJson(),
      );

      final userResponse = UserResponse.fromJson(response);

      _logger.i('Registration successful');
      return userResponse;
    } catch (e) {
      _logger.e('Registration failed: $e');
      rethrow;
    }
  }

  /// Save authentication token
  Future<void> saveToken(String token) async {
    try {
      await _storage.write(_tokenKey, token);
      _logger.d('Token saved successfully');
    } catch (e) {
      _logger.e('Failed to save token: $e');
      rethrow;
    }
  }

  /// Get saved authentication token
  String? getToken() {
    try {
      final token = _storage.read(_tokenKey);
      return token;
    } catch (e) {
      _logger.e('Failed to get token: $e');
      return null;
    }
  }

  /// Check if user is authenticated
  bool isAuthenticated() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  /// Save user data
  Future<void> saveUserData(UserResponse user) async {
    try {
      await _storage.write(_userKey, user.toJson());
      _logger.d('User data saved successfully');
    } catch (e) {
      _logger.e('Failed to save user data: $e');
      rethrow;
    }
  }

  /// Get saved user data
  UserResponse? getUserData() {
    try {
      final userData = _storage.read(_userKey);
      if (userData != null) {
        return UserResponse.fromJson(userData);
      }
      return null;
    } catch (e) {
      _logger.e('Failed to get user data: $e');
      return null;
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      await _storage.remove(_tokenKey);
      await _storage.remove(_userKey);
      _logger.i('Logout successful');
    } catch (e) {
      _logger.e('Logout failed: $e');
      rethrow;
    }
  }

  /// Clear all authentication data
  Future<void> clearAuth() async {
    try {
      await logout();
      _logger.i('Authentication data cleared');
    } catch (e) {
      _logger.e('Failed to clear authentication data: $e');
      rethrow;
    }
  }

  /// Get authorization header for API requests
  Map<String, String> getAuthHeader() {
    final token = getToken();
    if (token != null) {
      return {'Authorization': 'Bearer $token'};
    }
    return {};
  }
}
