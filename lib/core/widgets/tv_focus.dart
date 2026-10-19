import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class TvFocusWrapper extends StatelessWidget {
  final Widget child;
  final bool autofocus;

  const TvFocusWrapper({super.key, required this.child, this.autofocus = false});

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: autofocus,
      onKey: (node, event) {
        // Navegação D-pad para TV - delega para o foco nativo do Flutter
        return KeyEventResult.ignored;
      },
      child: child,
    );
  }
}

class FocusableButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final bool isFocused;

  const FocusableButton({super.key, required this.child, required this.onPressed, this.isFocused = false});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Focus(
        autofocus: isFocused,
        onKey: (node, event) {
          if (event.isKeyPressed(LogicalKeyboardButton.select)) {
            onPressed();
            return KeyEventResult.handled;
          }
          return KeyEventResult.ignored;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isFocused ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isFocused ? AppColors.primary : AppColors.border,
              width: isFocused ? 2 : 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
