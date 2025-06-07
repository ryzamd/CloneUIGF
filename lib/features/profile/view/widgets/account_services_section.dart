import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class AccountServicesSection extends StatelessWidget {
  const AccountServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          color: AppColors.white,
          margin: EdgeInsets.only(top: ResponsiveService.spacing8),
          padding: EdgeInsets.all(ResponsiveService.spacing16),
          child: Row(
            children: [
              Expanded(
                child: _ServiceCard(
                  title: 'Tạo Tài khoản Gia Đình',
                  icon: Icons.family_restroom,
                  onTap: () {},
                ),
              ),
              SizedBox(width: ResponsiveService.spacing12),
              Expanded(
                child: _ServiceCard(
                  title: 'Trung tâm Doanh nghiệp',
                  icon: Icons.business_center,
                  onTap: () {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(ResponsiveService.spacing16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusMedium),
        ),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusMedium),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryGreen,
                size: 32,
              ),
            ),
            SizedBox(height: ResponsiveService.spacing8),
            ResponsiveText.caption(
              text: title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}