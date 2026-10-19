import 'package:flutter/material.dart';
import 'package:tappo_streaming/core/theme/app_theme.dart';

class ProfilesScreen extends StatefulWidget {
  const ProfilesScreen({super.key});

  @override
  State<ProfilesScreen> createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends State<ProfilesScreen> {
  final List<Map<String, dynamic>> _profiles = [
    {'name': 'Sala', 'isDefault': true, 'avatar': '👤'},
    {'name': 'Quarto', 'isDefault': false, 'avatar': '👧'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Meus Perfis', style: AppTextStyles.heading2),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _profiles.length + 1,
              itemBuilder: (context, index) {
                if (index == _profiles.length) {
                  return _addProfileCard();
                }
                final profile = _profiles[index];
                return _profileCard(profile);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileCard(Map<String, dynamic> profile) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: CircleAvatar(
        backgroundColor: AppColors.surfaceElevated,
        child: Text(profile['avatar'] as String, style: const TextStyle(fontSize: 28)),
      ),
      title: Text(profile['name'] as String, style: AppTextStyles.body),
      trailing: profile['isDefault'] as bool
          ? const Icon(Icons.check, color: AppColors.primary)
          : const Icon(Icons.chevron_right, color: AppColors.textMuted),
      onTap: () {},
    );
  }

  Widget _addProfileCard() {
    if (_profiles.length >= 5) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Limite de 5 perfis atingido.', style: TextStyle(color: AppColors.textMuted)),
      );
    }
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.primary)),
        child: const Center(child: Icon(Icons.add, color: AppColors.primary)),
      ),
      title: const Text('Adicionar perfil', style: AppTextStyles.body),
      onTap: () {},
    );
  }
}
