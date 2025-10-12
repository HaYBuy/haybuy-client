import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  final storage = GetStorage();

  final token = storage.read('auth_token');

  print('=== Token Check ===');
  print('Token exists: ${token != null}');
  if (token != null) {
    print('Token value: $token');
    print('Token length: ${token.toString().length}');
  } else {
    print('No token found in storage');
  }
  print('===================');

  // Check all keys in storage
  print('\n=== All Storage Keys ===');
  final keys = storage.getKeys();
  print('Total keys: ${keys.length}');
  for (var key in keys) {
    print('Key: $key, Value: ${storage.read(key)}');
  }
}
