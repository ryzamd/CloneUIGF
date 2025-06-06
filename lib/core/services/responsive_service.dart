// lib/core/services/responsive_service.dart
import 'package:flutter/material.dart';

typedef ResponsiveBuilder = Widget Function(BuildContext context, ResponsiveService responsive);

enum DeviceType { mobile, tablet, desktop }
enum ScreenSize { small, medium, large, extraLarge }

class ResponsiveService {
  static late MediaQueryData _mediaQuery;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _safeAreaTop;
  static late double _safeAreaBottom;
  static late DeviceType _deviceType;
  static late ScreenSize _screenSize;

  // Khởi tạo service với context
  static void init(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    _screenWidth = _mediaQuery.size.width;
    _screenHeight = _mediaQuery.size.height;
    _safeAreaTop = _mediaQuery.padding.top;
    _safeAreaBottom = _mediaQuery.padding.bottom;
    _deviceType = _getDeviceType();
    _screenSize = _getScreenSize();
  }

  // Getters for screen dimensions
  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;
  static double get safeAreaTop => _safeAreaTop;
  static double get safeAreaBottom => _safeAreaBottom;
  static DeviceType get deviceType => _deviceType;
  static ScreenSize get screenSize => _screenSize;
  static double get pixelRatio => _mediaQuery.devicePixelRatio;

  // Determine device type based on screen width
  static DeviceType _getDeviceType() {
    if (_screenWidth < 600) {
      return DeviceType.mobile;
    } else if (_screenWidth < 1200) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  // Determine screen size category
  static ScreenSize _getScreenSize() {
    if (_screenWidth <= 360) {
      return ScreenSize.small;
    } else if (_screenWidth <= 410) {
      return ScreenSize.medium;
    } else if (_screenWidth <= 600) {
      return ScreenSize.large;
    } else {
      return ScreenSize.extraLarge;
    }
  }

  // Responsive width calculations
  static double widthPercent(double percent) {
    return _screenWidth * (percent / 100);
  }

  static double heightPercent(double percent) {
    return _screenHeight * (percent / 100);
  }

  // Safe responsive dimensions (excludes safe area)
  static double get safeScreenHeight => _screenHeight - _safeAreaTop - _safeAreaBottom;
  
  static double safeHeightPercent(double percent) {
    return safeScreenHeight * (percent / 100);
  }

  // Responsive spacing based on screen size
  static double get spacing4 => _getResponsiveValue(4, 6, 8, 10);
  static double get spacing8 => _getResponsiveValue(8, 10, 12, 14);
  static double get spacing12 => _getResponsiveValue(12, 14, 16, 18);
  static double get spacing16 => _getResponsiveValue(16, 18, 20, 22);
  static double get spacing20 => _getResponsiveValue(20, 22, 24, 26);
  static double get spacing24 => _getResponsiveValue(24, 26, 28, 30);
  static double get spacing32 => _getResponsiveValue(32, 34, 36, 38);

  // Responsive font sizes
  static double get fontSizeSmall => _getResponsiveValue(12, 13, 14, 15);
  static double get fontSizeMedium => _getResponsiveValue(14, 15, 16, 17);
  static double get fontSizeLarge => _getResponsiveValue(16, 17, 18, 19);
  static double get fontSizeXLarge => _getResponsiveValue(18, 19, 20, 21);
  static double get fontSizeXXLarge => _getResponsiveValue(20, 22, 24, 26);
  static double get fontSizeTitle => _getResponsiveValue(24, 26, 28, 30);
  static double get fontSizeHeading => _getResponsiveValue(28, 30, 32, 34);
  static double get fontSizeLargeTitle => _getResponsiveValue(48, 52, 64, 72);

  // Responsive icon sizes
  static double get iconSizeSmall => _getResponsiveValue(16, 18, 20, 22);
  static double get iconSizeMedium => _getResponsiveValue(20, 22, 24, 26);
  static double get iconSizeLarge => _getResponsiveValue(24, 26, 28, 30);
  static double get iconSizeXLarge => _getResponsiveValue(32, 34, 36, 38);

  // Responsive button heights
  static double get buttonHeightSmall => _getResponsiveValue(36, 38, 40, 42);
  static double get buttonHeightMedium => _getResponsiveValue(44, 46, 48, 50);
  static double get buttonHeightLarge => _getResponsiveValue(52, 54, 56, 58);

  // Container sizes
  static double get cardHeight => _getResponsiveValue(120, 130, 140, 150);
  static double get imageSize => _getResponsiveValue(60, 70, 80, 90);
  static double get avatarSize => _getResponsiveValue(40, 45, 50, 55);

  // Helper method to get responsive values based on screen size
  static double _getResponsiveValue(double small, double medium, double large, double extraLarge) {
    switch (_screenSize) {
      case ScreenSize.small:
        return small;
      case ScreenSize.medium:
        return medium;
      case ScreenSize.large:
        return large;
      case ScreenSize.extraLarge:
        return extraLarge;
    }
  }

  // Custom responsive value calculator
  static double responsive({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    switch (_deviceType) {
      case DeviceType.mobile:
        return mobile;
      case DeviceType.tablet:
        return tablet ?? mobile * 1.2;
      case DeviceType.desktop:
        return desktop ?? mobile * 1.5;
    }
  }

  // Responsive padding
  static EdgeInsets get paddingAll => EdgeInsets.all(spacing16);
  static EdgeInsets get paddingHorizontal => EdgeInsets.symmetric(horizontal: spacing16);
  static EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: spacing16);
  
  static EdgeInsets paddingOnly({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return EdgeInsets.only(
      left: left ?? 0,
      top: top ?? 0,
      right: right ?? 0,
      bottom: bottom ?? 0,
    );
  }

  // Responsive margin
  static EdgeInsets get marginAll => EdgeInsets.all(spacing16);
  static EdgeInsets get marginHorizontal => EdgeInsets.symmetric(horizontal: spacing16);
  static EdgeInsets get marginVertical => EdgeInsets.symmetric(vertical: spacing16);

  // Border radius
  static double get borderRadiusSmall => _getResponsiveValue(4, 6, 8, 10);
  static double get borderRadiusMedium => _getResponsiveValue(8, 10, 12, 14);
  static double get borderRadiusLarge => _getResponsiveValue(12, 14, 16, 18);
  static double get borderRadiusXLarge => _getResponsiveValue(16, 18, 20, 22);

  // Responsive layout helpers
  static int get gridCrossAxisCount {
    switch (_deviceType) {
      case DeviceType.mobile:
        return 2;
      case DeviceType.tablet:
        return 3;
      case DeviceType.desktop:
        return 4;
    }
  }

  static double get listItemHeight => _getResponsiveValue(70, 75, 80, 85);

  // App bar height
  static double get appBarHeight => _getResponsiveValue(56, 60, 64, 68);

  // Bottom navigation height
  static double get bottomNavHeight => _getResponsiveValue(60, 65, 70, 75);

  // Check if screen is small
  static bool get isSmallScreen => _screenSize == ScreenSize.small;
  static bool get isMediumScreen => _screenSize == ScreenSize.medium;
  static bool get isLargeScreen => _screenSize == ScreenSize.large;
  static bool get isExtraLargeScreen => _screenSize == ScreenSize.extraLarge;

  // Check device type
  static bool get isMobile => _deviceType == DeviceType.mobile;
  static bool get isTablet => _deviceType == DeviceType.tablet;
  static bool get isDesktop => _deviceType == DeviceType.desktop;

  // Debug info
  static Map<String, dynamic> get debugInfo => {
        'screenWidth': _screenWidth,
        'screenHeight': _screenHeight,
        'safeAreaTop': _safeAreaTop,
        'safeAreaBottom': _safeAreaBottom,
        'deviceType': _deviceType.toString(),
        'screenSize': _screenSize.toString(),
        'pixelRatio': pixelRatio,
      };

  // Responsive SizedBox utilities
  static Widget get spacingVerticalSmall => SizedBox(height: spacing8);
  static Widget get spacingVerticalMedium => SizedBox(height: spacing16);
  static Widget get spacingVerticalLarge => SizedBox(height: spacing24);
  static Widget get spacingVerticalXLarge => SizedBox(height: spacing32);

  static Widget get spacingHorizontalSmall => SizedBox(width: spacing8);
  static Widget get spacingHorizontalMedium => SizedBox(width: spacing16);
  static Widget get spacingHorizontalLarge => SizedBox(width: spacing24);
  static Widget get spacingHorizontalXLarge => SizedBox(width: spacing32);

  // Custom spacing
  static Widget verticalSpacing(double height) => SizedBox(height: height);
  static Widget horizontalSpacing(double width) => SizedBox(width: width);
}