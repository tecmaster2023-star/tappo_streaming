import 'package:flutter/material.dart';
import 'package:tappo_streaming/core/theme/app_theme.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String streamUrl;

  const VideoPlayerScreen({super.key, required this.streamUrl});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _controlsVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => setState(() => _controlsVisible = !_controlsVisible),
        child: Stack(
          children: [
            // Placeholder do player (substituir por just_audio/video_player real)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.videocam, size: 80, color: AppColors.textMuted),
                  const SizedBox(height: 16),
                  Text('Reproduzindo: ${widget.streamUrl.split('/').last}', style: const TextStyle(color: AppColors.textPrimary)),
                ],
              ),
            ),
            if (_controlsVisible)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Globo SP', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('Jornal Nacional • AO VIVO', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(icon: const Icon(Icons.subtitles, color: Colors.white), onPressed: () {}),
                          IconButton(icon: const Icon(Icons.volume_up, color: Colors.white), onPressed: () {}),
                          IconButton(icon: const Icon(Icons.cast, color: AppColors.primary), onPressed: () {}),
                          IconButton(
                            icon: const Icon(Icons.fullscreen, color: Colors.white),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
