import 'package:flutter/material.dart';
import '../constants/color_constant.dart';

enum ButtonSize { small, medium, large }
enum ButtonType { primary, secondary, outline }

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final ButtonSize size;
  final ButtonType type;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.size = ButtonSize.medium,
    this.type = ButtonType.primary,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: _getButtonHeight(),
      child: ElevatedButton(
        onPressed: _getOnPressed(),
        style: _getButtonStyle(),
        child: _buildContent(),
      ),
    );
  }

  VoidCallback? _getOnPressed() {
    if (!isEnabled || isLoading) return null;
    return onPressed;
  }

  double _getButtonHeight() {
    switch (size) {
      case ButtonSize.small:
        return 36;
      case ButtonSize.medium:
        return 48;
      case ButtonSize.large:
        return 56;
    }
  }

  ButtonStyle _getButtonStyle() {
    final baseStyle = ElevatedButton.styleFrom(
      elevation: type == ButtonType.outline ? 0 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: type == ButtonType.outline
            ? const BorderSide(color: AppColors.primaryGreen, width: 1)
            : BorderSide.none,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: _getHorizontalPadding(),
        vertical: 0,
      ),
    );

    switch (type) {
      case ButtonType.primary:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.lightGrey;
            }
            return backgroundColor ?? AppColors.primaryGreen;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.textHint;
            }
            return textColor ?? AppColors.textOnPrimary;
          }),
        );
      case ButtonType.secondary:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.lightGrey;
            }
            return backgroundColor ?? AppColors.lightGreen;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.textHint;
            }
            return textColor ?? AppColors.primaryGreen;
          }),
        );
      case ButtonType.outline:
        return baseStyle.copyWith(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.lightGrey;
            }
            return backgroundColor ?? AppColors.white;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return AppColors.textHint;
            }
            return textColor ?? AppColors.primaryGreen;
          }),
        );
    }
  }

  double _getHorizontalPadding() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 24;
      case ButtonSize.large:
        return 32;
    }
  }

  Widget _buildContent() {
    if (isLoading) {
      return SizedBox(
        height: _getLoadingSize(),
        width: _getLoadingSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            type == ButtonType.primary
                ? AppColors.textOnPrimary
                : AppColors.primaryGreen,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: _getFontSize(),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: _getFontSize(),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  double _getLoadingSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }

  double _getFontSize() {
    switch (size) {
      case ButtonSize.small:
        return 12;
      case ButtonSize.medium:
        return 14;
      case ButtonSize.large:
        return 16;
    }
  }
}