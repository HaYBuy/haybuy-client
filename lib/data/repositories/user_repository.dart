import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';
import 'package:haybuy_client/data/services/api/api_service.dart';
import 'package:haybuy_client/features/authentication/models/auth_models.dart';
import 'package:haybuy_client/features/shop/models/user_profile_model.dart';
import 'package:haybuy_client/utils/constants/api_constants.dart';

class UserRepository {
  final ApiService _apiService;
  final GetStorage _storage = GetStorage();
  final Logger _logger = Logger();

  UserRepository({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  /// Get authorization header
  Map<String, String> getAuthHeader() {
    final token = _storage.read('auth_token');
    _logger.d(
      'Token from storage: ${token != null ? "EXISTS (${token.toString().substring(0, 20)}...)" : "NULL"}',
    );

    if (token == null) {
      _logger.e('No authentication token found in storage');
      throw Exception('No authentication token found');
    }
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  /// Get current user profile
  Future<UserProfileModel> getMyProfile() async {
    try {
      _logger.i('Fetching user profile from: ${ApiConstants.getMyProfile}');

      final response = await _apiService.get(
        ApiConstants.getMyProfile,
        headers: getAuthHeader(),
      );

      final profile = UserProfileModel.fromJson(response);
      _logger.i('Profile fetched successfully');
      return profile;
    } catch (e) {
      _logger.e('Failed to fetch profile: $e');
      rethrow;
    }
  }

  /// Get current user data
  Future<UserResponse> getMe() async {
    try {
      _logger.i('Fetching user data from: ${ApiConstants.getMe}');

      final response = await _apiService.get(
        ApiConstants.getMe,
        headers: getAuthHeader(),
      );

      final user = UserResponse.fromJson(response);
      _logger.i('User data fetched successfully');
      return user;
    } catch (e) {
      _logger.e('Failed to fetch user data: $e');
      rethrow;
    }
  }

  /// Update user profile
  Future<UserProfileModel> updateProfile({
    String? phone,
    String? addressLine1,
    String? addressLine2,
    String? district,
    String? province,
    String? postalCode,
    double? latitude,
    double? longitude,
    bool? locationVerified,
    bool? idVerified,
  }) async {
    try {
      _logger.i('Updating user profile');

      final Map<String, dynamic> body = {};

      if (phone != null) body['phone'] = phone;
      if (addressLine1 != null) body['address_line1'] = addressLine1;
      if (addressLine2 != null) body['address_line2'] = addressLine2;
      if (district != null) body['district'] = district;
      if (province != null) body['province'] = province;
      if (postalCode != null) body['postal_code'] = postalCode;
      if (latitude != null) body['latitude'] = latitude;
      if (longitude != null) body['longitude'] = longitude;
      if (locationVerified != null)
        body['location_verified'] = locationVerified;
      if (idVerified != null) body['id_verified'] = idVerified;

      final response = await _apiService.put(
        ApiConstants.editMyProfile,
        body: body,
        headers: getAuthHeader(),
      );

      final profile = UserProfileModel.fromJson(response);
      _logger.i('Profile updated successfully');
      return profile;
    } catch (e) {
      _logger.e('Failed to update profile: $e');
      rethrow;
    }
  }

  /// Update user basic info (name, username)
  Future<UserResponse> updateUser({
    required String username,
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      _logger.i('Updating user data');

      final response = await _apiService.put(
        ApiConstants.updateMe,
        body: {
          'username': username,
          'full_name': fullName,
          'email': email,
          'password': password,
        },
        headers: getAuthHeader(),
      );

      final user = UserResponse.fromJson(response);
      _logger.i('User data updated successfully');
      return user;
    } catch (e) {
      _logger.e('Failed to update user data: $e');
      rethrow;
    }
  }

  /// Upload profile picture
  Future<String> uploadProfilePicture(String imagePath) async {
    try {
      _logger.i('Uploading profile picture');

      // TODO: Implement file upload when backend endpoint is ready
      // For now, return a placeholder URL
      await Future.delayed(const Duration(seconds: 1));

      _logger.i('Profile picture uploaded successfully');
      return 'https://placeholder.com/profile.jpg';
    } catch (e) {
      _logger.e('Failed to upload profile picture: $e');
      rethrow;
    }
  }

  /// Get all users
  Future<List<UserResponse>> getAllUsers() async {
    try {
      _logger.i('Fetching all users from: /v1/user/');

      final response = await _apiService.getList(
        '/v1/user/',
        headers: getAuthHeader(),
      );

      if (response is List) {
        final users = response
            .map((json) => UserResponse.fromJson(json as Map<String, dynamic>))
            .toList();
        _logger.i('Fetched ${users.length} users successfully');
        return users;
      }

      _logger.e(
        'Invalid response format: expected List, got ${response.runtimeType}',
      );
      throw Exception('Invalid response format');
    } catch (e) {
      _logger.e('Failed to fetch users: $e');
      rethrow;
    }
  }

  /// Get user by ID
  Future<UserResponse> getUserById(int userId) async {
    try {
      _logger.i('Fetching user $userId from: /v1/user/$userId');

      final response = await _apiService.get(
        '/v1/user/$userId',
        headers: getAuthHeader(),
      );

      final user = UserResponse.fromJson(response);
      _logger.i('User $userId fetched successfully');
      return user;
    } catch (e) {
      _logger.e('Failed to fetch user $userId: $e');
      rethrow;
    }
  }
}
