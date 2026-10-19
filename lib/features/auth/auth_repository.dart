import 'dart:convert';
import 'package:tappo_streaming/core/models/auth_response.dart';
import 'package:tappo_streaming/core/network/api_client.dart';
import 'package:tappo_streaming/core/network/api_constants.dart';
import 'package:tappo_streaming/core/storage/secure_storage.dart';
import 'package:tappo_streaming/core/utils/device_helper.dart';

class AuthRepository {
  final ApiClient _api;
  final SecureStorage _storage;

  AuthRepository(this._api, this._storage);

  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
    required String deviceId,
    required String deviceName,
    required String platform,
  }) async {
    final realDeviceId = await DeviceHelper.getDeviceId();
    final response = await _api.post(
      ApiConstants.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'device_id': realDeviceId,
        'device_name': deviceName,
        'platform': DeviceHelper.platformName,
      },
    );
    return AuthResponse.fromJson(jsonDecode(response.data) as Map<String, dynamic>);
  }

  Future<AuthResponse> login({
    required String email,
    required String password,
    required String deviceId,
  }) async {
    final realDeviceId = await DeviceHelper.getDeviceId();
    final response = await _api.post(
      ApiConstants.login,
      data: {'email': email, 'password': password, 'device_id': realDeviceId},
    );
    final authResponse = AuthResponse.fromJson(jsonDecode(response.data) as Map<String, dynamic>);
    await _storage.saveToken(authResponse.accessToken);
    await _storage.saveRefreshToken(authResponse.refreshToken);
    await _storage.saveUserId(authResponse.user.id);
    await _storage.saveDeviceId(realDeviceId);
    return authResponse;
  }

  Future<bool> isAuthenticated() async {
    final token = await _storage.readToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() async => await _storage.clear();
}
