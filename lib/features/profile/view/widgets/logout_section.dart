import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class LogoutSection extends StatelessWidget {
  const LogoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          color: AppColors.white,
          margin: EdgeInsets.only(top: ResponsiveService.spacing8),
          padding: EdgeInsets.all(ResponsiveService.spacing16),
          child: PrimaryButton(
            text: 'Đăng xuất',
            type: ButtonType.outline,
            onPressed: () => _handleLogout(context),
            backgroundColor: AppColors.white,
            textColor: AppColors.error,
          ),
        );
      },
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await ConfirmDialog.showLogout(context);
    if (confirmed == true && context.mounted) {
      NavigationService.toWelcome();
    }
  }
}