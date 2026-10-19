class Subscription {
  final String status;
  final String planType;
  final DateTime startsAt;
  final DateTime expiresAt;
  final int daysRemaining;
  final bool autoRenew;

  Subscription({required this.status, required this.planType, required this.startsAt, required this.expiresAt, required this.daysRemaining, required this.autoRenew});

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      status: json['status'] as String,
      planType: json['plan'] as String,
      startsAt: DateTime.parse(json['starts_at'] as String),
      expiresAt: DateTime.parse(json['expires_at'] as String),
      daysRemaining: json['days_remaining'] as int? ?? 0,
      autoRenew: json['auto_renew'] as bool? ?? false,
    );
  }

  bool get isActive => status == 'active' || status == 'trial';
  bool get isExpired => status == 'expired' || status == 'cancelled';
}
