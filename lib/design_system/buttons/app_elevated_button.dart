import 'package:flutter/material.dart';
import 'package:stack_gamification_platform/core/theme/app_colors.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style,
      onPressed: isLoading ? null : onPressed,
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.background,
                  ),
                  strokeWidth: 2,
                ),
              )
            : Text(label, textAlign: TextAlign.center),
      ),
    );
  }
}
