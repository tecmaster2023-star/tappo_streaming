class ApiConstants {
  static const String baseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:3333/v1');
  static const Duration timeout = Duration(seconds: 30);

  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String subscriptionStatus = '/subscription/status';
  static const String channels = '/channels';
  static const String channelStream = '/channels/{id}/stream';
  static const String vod = '/vod';
  static const String vodDetail = '/vod/{id}';
  static const String vodStream = '/vod/{id}/stream';
  static const String vodDownload = '/vod/{id}/download';
  static const String epg = '/epg';
  static const String devices = '/devices';
}
