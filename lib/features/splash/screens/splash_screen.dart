import 'package:flutter/material.dart';
import 'package:tappo_streaming/core/theme/app_theme.dart';
import 'package:tappo_streaming/injection_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 2));
    final isAuthenticated = await sl<AuthRepository>().isAuthenticated();
    if (mounted) {
      Navigator.pushReplacementNamed(context, isAuthenticated ? '/home' : '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.live_tv, size: 80, color: AppColors.primary),
            const SizedBox(height: 24),
            const Text('Tappo Streaming', style: AppTextStyles.heading1),
            const SizedBox(height: 16),
            const CircularProgressIndicator(color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
