class AuthResponse {
  final User user;
  final String accessToken;
  final String refreshToken;
  final Subscription subscription;

  AuthResponse({required this.user, required this.accessToken, required this.refreshToken, required this.subscription});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      subscription: Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
    );
  }
}
