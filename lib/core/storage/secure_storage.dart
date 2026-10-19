import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async => await _storage.write(key: 'access_token', value: token);
  Future<String?> readToken() async => await _storage.read(key: 'access_token');
  Future<void> saveRefreshToken(String token) async => await _storage.write(key: 'refresh_token', value: token);
  Future<String?> readRefreshToken() async => await _storage.read(key: 'refresh_token');
  Future<void> saveUserId(String userId) async => await _storage.write(key: 'user_id', value: userId);
  Future<String?> readUserId() async => await _storage.read(key: 'user_id');
  Future<void> saveDeviceId(String deviceId) async => await _storage.write(key: 'device_id', value: deviceId);
  Future<String?> readDeviceId() async => await _storage.read(key: 'device_id');

  Future<void> clear() async => await _storage.deleteAll();
}
