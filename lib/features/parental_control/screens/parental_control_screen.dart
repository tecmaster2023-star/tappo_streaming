import 'package:flutter/material.dart';
import 'package:tappo_streaming/core/theme/app_theme.dart';

class ParentalControlScreen extends StatefulWidget {
  const ParentalControlScreen({super.key});

  @override
  State<ParentalControlScreen> createState() => _ParentalControlScreenState();
}

class _ParentalControlScreenState extends State<ParentalControlScreen> {
  final _pinController = TextEditingController();
  int _maxRating = 12;
  bool _pinSet = false;

  final List<int> _ratings = [0, 10, 12, 14, 16, 18];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text('Controle Parental', style: AppTextStyles.heading2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Defina um PIN para bloquear conteúdos acima da classificação indicada.', style: AppTextStyles.body),
            const SizedBox(height: 32),
            Text('Classificação máxima permitida', style: AppTextStyles.caption),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children: _ratings.map((r) {
                final label = r == 0 ? 'Livre' : '$r anos';
                final selected = _maxRating == r;
                return ChoiceChip(
                  label: Text(label, style: const TextStyle(color: AppColors.textPrimary)),
                  selected: selected,
                  onSelected: (_) => setState(() => _maxRating = r),
                  selectedColor: AppColors.primary,
                  backgroundColor: AppColors.surface,
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            Text(_pinSet ? 'Alterar PIN' : 'Definir PIN (4 dígitos)', style: AppTextStyles.caption),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                return Container(
                  width: 44,
                  height: 44,
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.border, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      index < (_pinController.text.length) ? '●' : '',
                      style: const TextStyle(color: AppColors.primary, fontSize: 20),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _pinController.text.length == 4
                    ? () => setState(() => _pinSet = true)
                    : null,
                child: const Text('Salvar'),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _pinController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              obscureText: true,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 24),
              decoration: InputDecoration(
                counterText: '',
                hintText: '____',
                hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 24),
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
