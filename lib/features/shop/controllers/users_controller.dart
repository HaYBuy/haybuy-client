import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:haybuy_client/data/repositories/user_repository.dart';
import 'package:haybuy_client/features/authentication/models/auth_models.dart';
import 'package:haybuy_client/utils/popups/loaders.dart';

class UsersController extends GetxController {
  static UsersController get instance => Get.find();

  final _userRepository = UserRepository();
  final _logger = Logger();

  // Observable variables
  final RxList<UserResponse> users = <UserResponse>[].obs;
  final RxBool isLoading = false.obs;

  // Add currentUserId property
  final String currentUserId =
      'current_user_id'; // Replace with actual logic to fetch current user ID

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  /// Fetch all users
  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      _logger.i('Fetching all users...');

      final fetchedUsers = await _userRepository.getAllUsers();
      users.assignAll(fetchedUsers);

      _logger.i('Successfully fetched ${users.length} users');
    } catch (e) {
      _logger.e('Error fetching users: $e');
      Loaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to load users: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Get user by ID
  Future<UserResponse?> getUserById(int userId) async {
    try {
      _logger.i('Fetching user $userId...');
      final user = await _userRepository.getUserById(userId);
      _logger.i('Successfully fetched user $userId');
      return user;
    } catch (e) {
      _logger.e('Error fetching user $userId: $e');
      Loaders.errorSnackBar(title: 'Error', message: 'Failed to load user: $e');
      return null;
    }
  }

  /// Refresh users list
  Future<void> refreshUsers() async {
    await fetchUsers();
  }
}
