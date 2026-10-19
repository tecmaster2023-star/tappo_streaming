class User {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;

  User({required this.id, required this.name, required this.email, required this.createdAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}

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
