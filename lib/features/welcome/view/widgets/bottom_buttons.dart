import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          padding: EdgeInsets.all(ResponsiveService.spacing16),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: ResponsiveService.isSmallScreen
                ? _buildVerticalButtons(responsive)
                : _buildHorizontalButtons(responsive),
          ),
        );
      },
    );
  }

  Widget _buildVerticalButtons(ResponsiveService responsive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryButton(
          text: 'Đăng ký',
          type: ButtonType.outline,
          onPressed: () => NavigationService.toRegister(),
        ),
        SizedBox(height: ResponsiveService.spacing12),
        PrimaryButton(
          text: 'Đăng nhập',
          onPressed: () => NavigationService.toLogin(),
        ),
      ],
    );
  }

  Widget _buildHorizontalButtons(ResponsiveService responsive) {
    return Row(
      children: [
        Expanded(
          child: PrimaryButton(
            text: 'Đăng ký',
            type: ButtonType.outline,
            onPressed: () => NavigationService.toRegister(),
          ),
        ),
        SizedBox(width: ResponsiveService.spacing16),
        Expanded(
          child: PrimaryButton(
            text: 'Đăng nhập',
            onPressed: () => NavigationService.toLogin(),
          ),
        ),
      ],
    );
  }
}