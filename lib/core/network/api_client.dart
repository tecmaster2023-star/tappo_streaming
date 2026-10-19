import 'package:dio/dio.dart';
import 'package:tappo_streaming/core/network/api_constants.dart';
import 'package:tappo_streaming/core/storage/secure_storage.dart';

class ApiClient {
  final Dio _dio;
  final SecureStorage _storage;

  ApiClient(this._storage)
      : _dio = Dio(BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            connectTimeout: ApiConstants.timeout,
            receiveTimeout: ApiConstants.timeout,
            headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
          )) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storage.readToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Tentar refresh token
            final refreshToken = await _storage.readRefreshToken();
            if (refreshToken != null) {
              try {
                final response = await _dio.post(ApiConstants.refresh, data: {'refresh_token': refreshToken});
                final newToken = response.data['access_token'];
                final newRefresh = response.data['refresh_token'];
                await _storage.saveToken(newToken);
                await _storage.saveRefreshToken(newRefresh);
                options.headers['Authorization'] = 'Bearer $newToken';
                return handler.resolve(await _dio.fetch(options));
              } catch (_) {
                await _storage.clear();
                return handler.reject(error);
              }
            }
          }
          return handler.reject(error);
        },
      ),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return _dio.post(path, data: data);
  }

  Future<Response> delete(String path) async {
    return _dio.delete(path);
  }
}
