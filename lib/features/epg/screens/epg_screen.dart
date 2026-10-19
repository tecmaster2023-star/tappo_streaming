import 'package:flutter/material.dart';
import 'package:tappo_streaming/core/theme/app_theme.dart';

class EpgScreen extends StatefulWidget {
  const EpgScreen({super.key});

  @override
  State<EpgScreen> createState() => _EpgScreenState();
}

class _EpgScreenState extends State<EpgScreen> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Guia de Programação', style: AppTextStyles.heading2),
      ),
      body: Column(
        children: [
          _dateSelector(),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                final isNow = index == 0;
                return _epgRow(
                  channel: 'Canal ${index + 1}',
                  program: isNow ? 'Jornal Nacional' : 'Programação ${index + 1}',
                  time: '${18 + index}:00',
                  isNow: isNow,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateSelector() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final date = DateTime.now().add(Duration(days: index));
          final isSelected = index == 0;
          return GestureDetector(
            onTap: () => setState(() => _selectedDate = date),
            child: Container(
              width: 80,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${date.day}/${date.month}',
                    style: TextStyle(
                      color: isSelected ? Colors.black : AppColors.textSecondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _weekday(date.weekday),
                    style: TextStyle(
                      color: isSelected ? Colors.black : AppColors.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _weekday(int w) {
    const days = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
    return days[w - 1];
  }

  Widget _epgRow({required String channel, required String program, required String time, required bool isNow}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Container(
        width: 48,
        height: 32,
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(child: Text(channel, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary))),
      ),
      title: Text(program, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
      subtitle: Text(time, style: const TextStyle(color: AppColors.textSecondary)),
      trailing: isNow
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: AppColors.live, borderRadius: BorderRadius.circular(4)),
              child: const Text('AGORA', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            )
          : null,
      onTap: () {},
    );
  }
}
