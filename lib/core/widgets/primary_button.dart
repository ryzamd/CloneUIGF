import 'package:flutter/material.dart';
import '../constants/color_constant.dart';
import '../services/responsive_service.dart';

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
  final bool enableResponsive;

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
    this.enableResponsive = true,
  });

  @override
  Widget build(BuildContext context) {
    if (enableResponsive) {
      ResponsiveService.init(context);
    }

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
    if (enableResponsive) {
      switch (size) {
        case ButtonSize.small:
          return ResponsiveService.buttonHeightSmall;
        case ButtonSize.medium:
          return ResponsiveService.buttonHeightMedium;
        case ButtonSize.large:
          return ResponsiveService.buttonHeightLarge;
      }
    }
    
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
    final borderRadius = enableResponsive
        ? ResponsiveService.borderRadiusMedium
        : 8.0;
    
    final horizontalPadding = enableResponsive
        ? _getResponsiveHorizontalPadding()
        : _getHorizontalPadding();

    final baseStyle = ElevatedButton.styleFrom(
      elevation: type == ButtonType.outline ? 0 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: type == ButtonType.outline
            ? const BorderSide(color: AppColors.primaryGreen, width: 1)
            : BorderSide.none,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
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

  double _getResponsiveHorizontalPadding() {
    switch (size) {
      case ButtonSize.small:
        return ResponsiveService.spacing16;
      case ButtonSize.medium:
        return ResponsiveService.spacing20;
      case ButtonSize.large:
        return ResponsiveService.spacing24;
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

    final fontSize = enableResponsive ? _getResponsiveFontSize() : _getFontSize();
    final iconSpacing = enableResponsive ? ResponsiveService.spacing8 : 8.0;

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          SizedBox(width: iconSpacing),
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  double _getResponsiveFontSize() {
    switch (size) {
      case ButtonSize.small:
        return ResponsiveService.fontSizeSmall;
      case ButtonSize.medium:
        return ResponsiveService.fontSizeMedium;
      case ButtonSize.large:
        return ResponsiveService.fontSizeLarge;
    }
  }

  double _getLoadingSize() {
    if (enableResponsive) {
      switch (size) {
        case ButtonSize.small:
          return ResponsiveService.iconSizeSmall;
        case ButtonSize.medium:
          return ResponsiveService.iconSizeMedium;
        case ButtonSize.large:
          return ResponsiveService.iconSizeLarge;
      }
    }
    
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