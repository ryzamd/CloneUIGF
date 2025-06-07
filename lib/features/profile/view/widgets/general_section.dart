import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class GeneralSection extends StatelessWidget {
  const GeneralSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          color: AppColors.white,
          margin: EdgeInsets.only(top: ResponsiveService.spacing8),
          padding: EdgeInsets.all(ResponsiveService.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveText.title(
                text: 'Tổng quát',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: ResponsiveService.spacing16),
              _GeneralItem(
                title: 'Cài đặt',
                icon: Icons.settings,
                onTap: () {},
              ),
              _GeneralItem(
                title: 'Trợ giúp',
                icon: Icons.help_outline,
                onTap: () {},
              ),
              _GeneralItem(
                title: 'Điều khoản & Chính sách',
                icon: Icons.description_outlined,
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GeneralItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _GeneralItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ResponsiveService.spacing12),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.textSecondary,
              size: ResponsiveService.iconSizeMedium,
            ),
            SizedBox(width: ResponsiveService.spacing16),
            Expanded(
              child: ResponsiveText.body(
                text: title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.mediumGrey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}