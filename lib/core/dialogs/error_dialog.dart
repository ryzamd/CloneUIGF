import 'package:flutter/material.dart';
import '../constants/color_constant.dart';
import '../constants/string_constant.dart';
import '../widgets/primary_button.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final bool barrierDismissible;

  const ErrorDialog({
    super.key,
    required this.title,
    required this.message,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.barrierDismissible = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.all(24),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Error Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.error_outline,
              color: AppColors.error,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          
          // Title
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          
          // Message
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          
          // Buttons
          Row(
            children: [
              if (secondaryButtonText != null) ...[
                Expanded(
                  child: PrimaryButton(
                    text: secondaryButtonText!,
                    type: ButtonType.outline,
                    onPressed: onSecondaryPressed ?? () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: PrimaryButton(
                  text: primaryButtonText ?? AppStrings.ok,
                  onPressed: onPrimaryPressed ?? () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    String? primaryButtonText,
    String? secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    bool barrierDismissible = true,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => ErrorDialog(
        title: title,
        message: message,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        onSecondaryPressed: onSecondaryPressed,
        barrierDismissible: barrierDismissible,
      ),
    );
  }
}