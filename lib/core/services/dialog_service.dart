import 'package:flutter/material.dart';
import '../dialogs/error_dialog.dart';
import '../dialogs/confirm_dialog.dart';
import '../dialogs/notification_dialog.dart';
import '../constants/string_constant.dart';
import 'navigation_service.dart';

class DialogService {
  static BuildContext? get _context {
    final context = NavigationService.navigator.context;
    return context.mounted ? context : null;
  }
  
  static BuildContext get context {
    final ctx = _context;
    if (ctx == null) {
      throw Exception('Navigation context is not available');
    }
    return ctx;
  }

  // Error Dialogs
  static Future<void> showError({
    required String message,
    String? title,
    String? buttonText,
    VoidCallback? onPressed,
  }) {
    return ErrorDialog.show(
      context: context,
      title: title ?? 'Lỗi',
      message: message,
      primaryButtonText: buttonText,
      onPrimaryPressed: onPressed,
    );
  }

  static Future<void> showNetworkError({
    VoidCallback? onRetry,
  }) {
    return ErrorDialog.show(
      context: context,
      title: 'Lỗi kết nối',
      message: AppStrings.errorNetwork,
      primaryButtonText: AppStrings.retry,
      secondaryButtonText: AppStrings.cancel,
      onPrimaryPressed: onRetry,
    );
  }

  static Future<void> showValidationError(String message) {
    return ErrorDialog.show(
      context: context,
      title: 'Dữ liệu không hợp lệ',
      message: message,
      primaryButtonText: AppStrings.ok,
    );
  }

  // Confirmation Dialogs
  static Future<bool?> showConfirmation({
    required String title,
    required String message,
    String confirmText = 'Xác nhận',
    String cancelText = 'Hủy',
    VoidCallback? onConfirm,
    bool isDangerous = false,
  }) {
    return ConfirmDialog.show(
      context: context,
      title: title,
      message: message,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      isDangerous: isDangerous,
    );
  }

  static Future<bool?> showLogoutConfirmation() {
    return ConfirmDialog.showLogout(context);
  }

  static Future<bool?> showDeleteConfirmation({
    required String itemName,
    VoidCallback? onConfirm,
  }) {
    return ConfirmDialog.showDelete(
      context: context,
      itemName: itemName,
      onConfirm: onConfirm,
    );
  }

  // Notification Dialogs
  static Future<void> showSuccess({
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
    bool autoDismiss = false,
  }) {
    return NotificationDialog.showSuccess(
      context: context,
      title: title,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed,
      autoDismiss: autoDismiss,
    );
  }

  static Future<void> showInfo({
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
    bool autoDismiss = false,
  }) {
    return NotificationDialog.showInfo(
      context: context,
      title: title,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed,
      autoDismiss: autoDismiss,
    );
  }

  static Future<void> showWarning({
    required String title,
    required String message,
    String? buttonText,
    VoidCallback? onPressed,
  }) {
    return NotificationDialog.showWarning(
      context: context,
      title: title,
      message: message,
      buttonText: buttonText,
      onPressed: onPressed,
    );
  }

  // Snackbar Messages
  static void showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    Color? backgroundColor,
  }) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  static void showSuccessSnackBar(String message) {
    showSnackBar(
      message: message,
      backgroundColor: Colors.green,
    );
  }

  static void showErrorSnackBar(String message) {
    showSnackBar(
      message: message,
      backgroundColor: Colors.red,
    );
  }

  static void showInfoSnackBar(String message) {
    showSnackBar(
      message: message,
      backgroundColor: Colors.blue,
    );
  }

  // Loading Dialog
  static void showLoading({String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          content: SizedBox(
            width: 100,
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                const CircularProgressIndicator(),
                Expanded(
                  child: Text(
                    message ?? AppStrings.loading,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void hideLoading() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  // Input Dialog
  static Future<String?> showInputDialog({
    required String title,
    required String hint,
    String? initialValue,
    String confirmText = 'Xác nhận',
    String cancelText = 'Hủy',
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    final controller = TextEditingController(text: initialValue);
    final formKey = GlobalKey<FormState>();

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(hintText: hint),
            keyboardType: keyboardType,
            obscureText: obscureText,
            validator: validator,
            autofocus: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                Navigator.of(context).pop(controller.text);
              }
            },
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  // Bottom Sheet
  static Future<T?> showBottomSheet<T>({
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return NavigationService.showCustomBottomSheet<T>(
      child: child,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }
}