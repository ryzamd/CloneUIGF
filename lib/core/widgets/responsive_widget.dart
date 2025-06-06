// lib/core/widgets/responsive_widget.dart
import 'package:flutter/material.dart';
import '../services/responsive_service.dart';

class ResponsiveWidget extends StatelessWidget {
  final ResponsiveBuilder builder;

  const ResponsiveWidget({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveService.init(context);
    return builder(context, ResponsiveService());
  }
}

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final AlignmentGeometry? alignment;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveService.init(context);
    
    return Container(
      width: width,
      height: height,
      padding: padding ?? ResponsiveService.paddingAll,
      margin: margin,
      decoration: decoration,
      alignment: alignment,
      child: child,
    );
  }
}

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final ResponsiveTextType type;

  const ResponsiveText({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.type = ResponsiveTextType.body,
  });

  const ResponsiveText.heading({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : type = ResponsiveTextType.heading;

  const ResponsiveText.title({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : type = ResponsiveTextType.title;

  const ResponsiveText.body({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : type = ResponsiveTextType.body;

  const ResponsiveText.caption({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : type = ResponsiveTextType.caption;

  @override
  Widget build(BuildContext context) {
    ResponsiveService.init(context);
    
    double fontSize;
    FontWeight fontWeight;
    
    switch (type) {
      case ResponsiveTextType.heading:
        fontSize = ResponsiveService.fontSizeHeading;
        fontWeight = FontWeight.bold;
        break;
      case ResponsiveTextType.title:
        fontSize = ResponsiveService.fontSizeTitle;
        fontWeight = FontWeight.w600;
        break;
      case ResponsiveTextType.body:
        fontSize = ResponsiveService.fontSizeMedium;
        fontWeight = FontWeight.normal;
        break;
      case ResponsiveTextType.caption:
        fontSize = ResponsiveService.fontSizeSmall;
        fontWeight = FontWeight.normal;
        break;
    }

    return Text(
      text,
      style: style?.copyWith(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ) ?? TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

enum ResponsiveTextType {
  heading,
  title,
  body,
  caption,
}

class ResponsiveButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ResponsiveButtonSize size;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? icon;

  const ResponsiveButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.size = ResponsiveButtonSize.medium,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    ResponsiveService.init(context);
    
    double height;
    double fontSize;
    EdgeInsets padding;
    
    switch (size) {
      case ResponsiveButtonSize.small:
        height = ResponsiveService.buttonHeightSmall;
        fontSize = ResponsiveService.fontSizeSmall;
        padding = EdgeInsets.symmetric(horizontal: ResponsiveService.spacing16);
        break;
      case ResponsiveButtonSize.medium:
        height = ResponsiveService.buttonHeightMedium;
        fontSize = ResponsiveService.fontSizeMedium;
        padding = EdgeInsets.symmetric(horizontal: ResponsiveService.spacing20);
        break;
      case ResponsiveButtonSize.large:
        height = ResponsiveService.buttonHeightLarge;
        fontSize = ResponsiveService.fontSizeLarge;
        padding = EdgeInsets.symmetric(horizontal: ResponsiveService.spacing24);
        break;
    }

    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusMedium),
          ),
          padding: padding,
        ),
        child: isLoading
            ? SizedBox(
                height: ResponsiveService.iconSizeSmall,
                width: ResponsiveService.iconSizeSmall,
                child: const CircularProgressIndicator(strokeWidth: 2),
              )
            : icon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      icon!,
                      SizedBox(width: ResponsiveService.spacing8),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
      ),
    );
  }
}

enum ResponsiveButtonSize { small, medium, large }