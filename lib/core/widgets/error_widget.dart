import 'package:flutter/material.dart';
import '../constants/color_constant.dart';
import '../constants/string_constant.dart';
import 'primary_button.dart';

class AppErrorWidget extends StatelessWidget {
  final String? message;
  final String? title;
  final VoidCallback? onRetry;
  final IconData? icon;
  final bool showRetryButton;

  const AppErrorWidget({
    super.key,
    this.message,
    this.title,
    this.onRetry,
    this.icon,
    this.showRetryButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.error_outline,
              size: 64,
              color: AppColors.error,
            ),
            const SizedBox(height: 16),
            if (title != null) ...[
              Text(
                title!,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            Text(
              message ?? AppStrings.errorGeneral,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (showRetryButton && onRetry != null) ...[
              const SizedBox(height: 24),
              PrimaryButton(
                text: AppStrings.retry,
                onPressed: onRetry,
                size: ButtonSize.medium,
                width: 120,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class NetworkErrorWidget extends StatelessWidget {
  final VoidCallback? onRetry;

  const NetworkErrorWidget({
    super.key,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AppErrorWidget(
      title: 'Lỗi kết nối',
      message: AppStrings.errorNetwork,
      icon: Icons.wifi_off,
      onRetry: onRetry,
    );
  }
}

class EmptyStateWidget extends StatelessWidget {
  final String? message;
  final String? title;
  final IconData? icon;
  final Widget? action;

  const EmptyStateWidget({
    super.key,
    this.message,
    this.title,
    this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: 64,
              color: AppColors.mediumGrey,
            ),
            const SizedBox(height: 16),
            if (title != null) ...[
              Text(
                title!,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            if (message != null) ...[
              Text(
                message!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(FlutterErrorDetails)? errorBuilder;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  FlutterErrorDetails? _errorDetails;

  @override
  void initState() {
    super.initState();
    FlutterError.onError = (details) {
      if (mounted) {
        setState(() {
          _errorDetails = details;
        });
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_errorDetails != null) {
      return widget.errorBuilder?.call(_errorDetails!) ??
          AppErrorWidget(
            title: 'Có lỗi xảy ra',
            message: 'Ứng dụng gặp sự cố. Vui lòng thử lại.',
            onRetry: () {
              setState(() {
                _errorDetails = null;
              });
            },
          );
    }

    return widget.child;
  }
}