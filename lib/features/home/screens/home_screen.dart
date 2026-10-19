import 'package:flutter/material.dart';
import 'package:tappo_streaming/core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Tappo Streaming', style: AppTextStyles.heading1),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        ],
      ),
      body: ListView(
        children: [
          _sectionTitle('Canais ao Vivo'),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (_, i) => ChannelCard(
                name: 'Canal ${i + 1}',
                isLive: i == 0,
                onTap: () {},
              ),
            ),
          ),
          _sectionTitle('Filmes'),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (_, i) => ContentCard(title: 'Filme ${i + 1}', onTap: () {}),
            ),
          ),
          _sectionTitle('Séries'),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (_, i) => ContentCard(title: 'Série ${i + 1}', onTap: () {}),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Ao Vivo'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Filmes'),
          BottomNavigationBarItem(icon: Icon(Icons.download), label: 'Downloads'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Conta'),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Text(title, style: AppTextStyles.heading2),
      );
}

class ChannelCard extends StatelessWidget {
  final String name;
  final bool isLive;
  final VoidCallback onTap;

  const ChannelCard({super.key, required this.name, required this.isLive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(color: AppColors.surfaceElevated),
                  ),
                  if (isLive)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: AppColors.live, borderRadius: BorderRadius.circular(4)),
                        child: const Text('AO VIVO', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(name, style: AppTextStyles.body, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

class ContentCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ContentCard({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(color: AppColors.surfaceElevated),
              ),
            ),
            const SizedBox(height: 8),
            Text(title, style: AppTextStyles.body, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
