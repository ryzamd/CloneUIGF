import 'package:flutter/material.dart';
import '../constants/color_constant.dart';
import '../constants/string_constant.dart';
import '../widgets/primary_button.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final IconData? icon;
  final Color? iconColor;
  final bool isDangerous;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Xác nhận',
    this.cancelText = 'Hủy',
    this.onConfirm,
    this.onCancel,
    this.icon,
    this.iconColor,
    this.isDangerous = false,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = isDangerous ? AppColors.error : (iconColor ?? AppColors.warning);
    final effectiveIcon = icon ?? (isDangerous ? Icons.warning : Icons.help_outline);

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
              color: effectiveIconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              effectiveIcon,
              color: effectiveIconColor,
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
              Expanded(
                child: PrimaryButton(
                  text: cancelText,
                  type: ButtonType.outline,
                  onPressed: onCancel ?? () => Navigator.of(context).pop(false),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: PrimaryButton(
                  text: confirmText,
                  backgroundColor: isDangerous ? AppColors.error : null,
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    onConfirm?.call();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Xác nhận',
    String cancelText = 'Hủy',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    IconData? icon,
    Color? iconColor,
    bool isDangerous = false,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmDialog(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        icon: icon,
        iconColor: iconColor,
        isDangerous: isDangerous,
      ),
    );
  }

  static Future<bool?> showLogout(BuildContext context) {
    return show(
      context: context,
      title: 'Đăng xuất',
      message: AppStrings.logoutConfirm,
      confirmText: AppStrings.logout,
      cancelText: AppStrings.cancel,
      icon: Icons.logout,
      iconColor: AppColors.warning,
    );
  }

  static Future<bool?> showDelete({
    required BuildContext context,
    required String itemName,
    VoidCallback? onConfirm,
  }) {
    return show(
      context: context,
      title: 'Xóa $itemName',
      message: 'Bạn có chắc muốn xóa $itemName? Hành động này không thể hoàn tác.',
      confirmText: AppStrings.delete,
      cancelText: AppStrings.cancel,
      onConfirm: onConfirm,
      isDangerous: true,
    );
  }
}