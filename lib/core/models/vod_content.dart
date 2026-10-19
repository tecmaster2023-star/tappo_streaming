class VodContent {
  final String id;
  final String title;
  final String type;
  final List<String> genre;
  final int? year;
  final int? rating;
  final String? synopsis;
  final String? posterUrl;
  final String? backdropUrl;
  final int? durationMin;
  final List<String> audioTracks;
  final List<String> subtitleTracks;
  final bool isDownloadable;

  VodContent({
    required this.id,
    required this.title,
    required this.type,
    required this.genre,
    this.year,
    this.rating,
    this.synopsis,
    this.posterUrl,
    this.backdropUrl,
    this.durationMin,
    required this.audioTracks,
    required this.subtitleTracks,
    required this.isDownloadable,
  });

  factory VodContent.fromJson(Map<String, dynamic> json) {
    return VodContent(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      genre: (json['genre'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      year: json['year'] as int?,
      rating: json['rating'] as int?,
      synopsis: json['synopsis'] as String?,
      posterUrl: json['poster_url'] as String?,
      backdropUrl: json['backdrop_url'] as String?,
      durationMin: json['duration_min'] as int?,
      audioTracks: (json['audio_tracks'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      subtitleTracks: (json['subtitle_tracks'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      isDownloadable: json['is_downloadable'] as bool? ?? false,
    );
  }
}

class VodStreamResponse {
  final String streamUrl;
  final String? downloadUrl;
  final DateTime expiresAt;
  final bool drmRequired;

  VodStreamResponse({required this.streamUrl, this.downloadUrl, required this.expiresAt, required this.drmRequired});

  factory VodStreamResponse.fromJson(Map<String, dynamic> json) {
    return VodStreamResponse(
      streamUrl: json['stream_url'] as String,
      downloadUrl: json['download_url'] as String?,
      expiresAt: DateTime.parse(json['expires_at'] as String),
      drmRequired: json['drm_required'] as bool? ?? false,
    );
  }
}
