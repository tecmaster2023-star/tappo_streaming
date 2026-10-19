class Channel {
  final String id;
  final String name;
  final String category;
  final String? logoUrl;
  final bool isLive;
  final String streamType;
  final String? epgId;

  Channel({required this.id, required this.name, required this.category, this.logoUrl, required this.isLive, required this.streamType, this.epgId});

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      logoUrl: json['logo_url'] as String?,
      isLive: json['is_live'] as bool? ?? false,
      streamType: json['stream_type'] as String? ?? 'hls',
      epgId: json['epg_id'] as String?,
    );
  }
}

class ChannelStreamResponse {
  final String streamUrl;
  final DateTime expiresAt;
  final bool drmRequired;

  ChannelStreamResponse({required this.streamUrl, required this.expiresAt, required this.drmRequired});

  factory ChannelStreamResponse.fromJson(Map<String, dynamic> json) {
    return ChannelStreamResponse(
      streamUrl: json['stream_url'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String),
      drmRequired: json['drm_required'] as bool? ?? false,
    );
  }
}
