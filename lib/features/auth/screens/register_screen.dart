import 'package:flutter/material.dart';
import 'package:tappo_streaming/core/theme/app_theme.dart';
import 'package:tappo_streaming/injection_container.dart';
import 'package:tappo_streaming/core/utils/device_helper.dart';
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _acceptTerms = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptTerms) {
      setState(() => _error = 'Você deve aceitar os termos de uso e política de privacidade.');
      return;
    }
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      await sl<AuthRepository>().register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        deviceId: 'mock-device-id',
        deviceName: 'Dispositivo Mobile',
        platform: 'android',
      );
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      setState(() => _error = 'Erro ao criar conta. Tente novamente.');
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
                  const Text('Criar conta', style: AppTextStyles.heading1),
                  const SizedBox(height: 8),
                  const Text('Comece seu teste gratuito', style: AppTextStyles.body),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _nameController,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Nome completo',
                      labelStyle: const TextStyle(color: AppColors.textSecondary),
                      prefixIcon: const Icon(Icons.person, color: AppColors.textSecondary),
                    ),
                    validator: (v) => (v == null || v.length < 3) ? 'Nome muito curto' : null,
                  ),
                  const SizedBox(height: 16),
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
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _confirmController,
                    obscureText: true,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      labelText: 'Confirmar senha',
                      labelStyle: const TextStyle(color: AppColors.textSecondary),
                      prefixIcon: const Icon(Icons.lock, color: AppColors.textSecondary),
                    ),
                    validator: (v) => (v == null || v != _passwordController.text) ? 'Senhas não coincidem' : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _acceptTerms,
                        activeColor: AppColors.primary,
                        onChanged: (v) => setState(() => _acceptTerms = v ?? false),
                      ),
                      const Expanded(
                        child: Text('Concordo com os Termos de Uso e Política de Privacidade', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                      ),
                    ],
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
                      onPressed: _isLoading ? null : _register,
                      child: _isLoading ? const CircularProgressIndicator(strokeWidth: 2) : const Text('Criar conta'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Já tem conta? Faça login', style: TextStyle(color: AppColors.primary)),
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
