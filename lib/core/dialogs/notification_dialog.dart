import 'package:flutter/material.dart';
import '../constants/color_constant.dart';
import '../constants/string_constant.dart';
import '../widgets/primary_button.dart';

enum NotificationType { success, info, warning, error }

class NotificationDialog extends StatelessWidget {
  final String title;
  final String message;
  final NotificationType type;
  final String? buttonText;
  final VoidCallback? onPressed;
  final bool autoDismiss;
  final Duration autoDismissDuration;

  const NotificationDialog({
    super.key,
    required this.title,
    required this.message,
    this.type = NotificationType.info,
    this.buttonText,
    this.onPressed,
    this.autoDismiss = false,
    this.autoDismissDuration = const Duration(seconds: 3),
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
          // Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getIconColor().withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getIcon(),
              color: _getIconColor(),
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
          
          // Button
          PrimaryButton(
            text: buttonText ?? AppStrings.ok,
            onPressed: onPressed ?? () => Navigator.of(context).pop(),
            backgroundColor: _getButtonColor(),
          ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    switch (type) {
      case NotificationType.success:
        return Icons.check_circle_outline;
      case NotificationType.info:
        return Icons.info_outline;
      case NotificationType.warning:
        return Icons.warning_outlined;
      case NotificationType.error:
        return Icons.error_outline;
    }
  }

  Color _getIconColor() {
    switch (type) {
      case NotificationType.success:
        return AppColors.success;
      case NotificationType.info:
        return AppColors.info;
      case NotificationType.warning:
        return AppColors.warning;
      case NotificationType.error:
        return AppColors.error;
    }
  }

  Color _getButtonColor() {
    switch (type) {
      case NotificationType.success:
        return AppColors.success;
      case NotificationType.info:
        return AppColors.primaryGreen;
      case NotificationType.warning:
        return AppColors.warning;
      case NotificationType.error:
        return AppColors.error;
    }
  }

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    NotificationType type = NotificationType.info,
    String? buttonText,
    VoidCallback? onPressed,
    bool autoDismiss = false,
    Duration autoDismissDuration = const Duration(seconds: 3),
  }) async {
    final dialog = showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => NotificationDialog(
        title: title,
        message: message,
        type: type,
        buttonText: buttonText,
        onPressed: onPressed,
        autoDismiss: autoDismiss,
        autoDismissDuration: autoDismissDuration,
      ),
    );

    if (autoDismiss) {
      Future.delayed(autoDismissDuration, () {
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      });
    }

    return dialog;
  }

  static Future<void> showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
    bool autoDismiss = true,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      type: NotificationType.success,
      buttonText: buttonText,
      onPressed: onPressed,
      autoDismiss: autoDismiss,
    );
  }

  static Future<void> showError({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      type: NotificationType.error,
      buttonText: buttonText,
      onPressed: onPressed,
    );
  }

  static Future<void> showInfo({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
    bool autoDismiss = false,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      type: NotificationType.info,
      buttonText: buttonText,
      onPressed: onPressed,
      autoDismiss: autoDismiss,
    );
  }

  static Future<void> showWarning({
    required BuildContext context,
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
  }) {
    return show(
      context: context,
      title: title,
      message: message,
      type: NotificationType.warning,
      buttonText: buttonText,
      onPressed: onPressed,
    );
  }
}