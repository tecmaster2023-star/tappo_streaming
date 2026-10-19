import 'package:flutter/material.dart';
import 'package:tappo_streaming/core/theme/app_theme.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({super.key});

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  final List<Map<String, dynamic>> _downloads = [
    {'title': 'Filme Exemplo 1', 'progress': 1.0, 'status': 'concluído'},
    {'title': 'Série Exemplo - Ep. 2', 'progress': 0.65, 'status': 'baixando'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Meus Downloads', style: AppTextStyles.heading2),
      ),
      body: _downloads.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.download_off, size: 64, color: AppColors.textMuted),
                  SizedBox(height: 16),
                  Text('Nenhum download', style: AppTextStyles.body),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _downloads.length,
              itemBuilder: (context, index) {
                final item = _downloads[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  leading: Container(
                    width: 64,
                    height: 96,
                    color: AppColors.surfaceElevated,
                    child: const Center(child: Icon(Icons.movie, color: AppColors.textMuted)),
                  ),
                  title: Text(item['title'] as String, style: AppTextStyles.body),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(
                        value: item['progress'] as double,
                        backgroundColor: AppColors.border,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 4),
                      Text(item['status'] as String, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.error),
                    onPressed: () => setState(() => _downloads.removeAt(index)),
                  ),
                  onTap: () {},
                );
              },
            ),
    );
  }
}
