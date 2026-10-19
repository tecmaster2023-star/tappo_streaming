import 'package:flutter/material.dart';
import 'package:tappo_streaming/core/theme/app_theme.dart';
import 'package:tappo_streaming/injection_container.dart';
import 'package:tappo_streaming/core/utils/device_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState> _LoginScreenState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      await sl<AuthRepository>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        deviceId: 'mock-device-id',
      );
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() => _error = 'E-mail ou senha incorretos.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Tappo Streaming', style: AppTextStyles.heading1),
                  const SizedBox(height: 8),
                  const Text('Bem-vindo de volta', style: AppTextStyles.body),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: const TextStyle(color: AppColors.textSecondary),
                      prefixIcon: const Icon(Icons.email, color: AppColors.textSecondary),
                    ),
                    validator: (v) => (v == null || v.isEmpty || !v.contains('@')) ? 'E-mail inválido' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: const TextStyle(color: AppColors.textSecondary),
                      prefixIcon: const Icon(Icons.lock, color: AppColors.textSecondary),
                    ),
                    validator: (v) => (v == null || v.length < 8) ? 'Senha deve ter 8+ caracteres' : null,
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(_error!, style: const TextStyle(color: AppColors.error)),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading ? const CircularProgressIndicator(strokeWidth: 2) : const Text('Entrar'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Esqueceu a senha?', style: TextStyle(color: AppColors.textSecondary)),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Criar conta', style: TextStyle(color: AppColors.primary)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
