import 'package:flutter/material.dart';
import '../../../../../core/core.dart';

class LogoutHeader extends StatelessWidget {
  const LogoutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          color: AppColors.white,
          padding: EdgeInsets.all(ResponsiveService.spacing16),
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => NavigationService.goBack(),
                  child: Container(
                    padding: EdgeInsets.all(ResponsiveService.spacing8),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.textSecondary,
                      size: 24,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}