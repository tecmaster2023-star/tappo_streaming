class Profile {
  final String id;
  final String name;
  final String? avatarUrl;
  final bool isDefault;
  final int? maxRating;

  Profile({required this.id, required this.name, this.avatarUrl, required this.isDefault, this.maxRating});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String?,
      isDefault: json['is_default'] as bool? ?? false,
      maxRating: json['max_rating'] as int?,
    );
  }
}
