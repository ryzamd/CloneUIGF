import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(ResponsiveService.spacing20),
          decoration: BoxDecoration(
            color: AppColors.primaryGreen,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(ResponsiveService.borderRadiusLarge),
              bottomRight: Radius.circular(ResponsiveService.borderRadiusLarge),
            ),
          ),
          child:
              ResponsiveService.isMobile
                  ? _buildMobileLayout(responsive)
                  : _buildTabletLayout(responsive),
        );
      },
    );
  }

  Widget _buildMobileLayout(ResponsiveService responsive) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveText.title(
                text: 'Chưa có tài khoản Grab?',
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w100,
                  fontSize: 10,
                ),
              ),
              SizedBox(height: ResponsiveService.spacing8),
              ResponsiveText.body(
                text: 'Đăng ký để hưởng các tiện ích!',
                style: const TextStyle(color: AppColors.white),
              ),
            ],
          ),
        ),
        SizedBox(width: ResponsiveService.spacing16),
        Container(
          width: ResponsiveService.imageSize,
          height: ResponsiveService.imageSize,
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(
              ResponsiveService.borderRadiusMedium,
            ),
          ),
          child: Icon(
            Icons.person,
            color: AppColors.white,
            size: ResponsiveService.iconSizeXLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildTabletLayout(ResponsiveService responsive) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveText.title(
                text: 'Chưa có tài khoản Grab?',
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: ResponsiveService.spacing8),
              Row(
                children: [
                  ResponsiveText.body(
                    text: 'Đăng ký để hưởng các tiện ích!',
                    style: const TextStyle(color: AppColors.white),
                  ),
                  SizedBox(width: ResponsiveService.spacing8),
                  Icon(
                    Icons.arrow_forward,
                    color: AppColors.white,
                    size: ResponsiveService.iconSizeMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: ResponsiveService.spacing16),
        Container(
          width: ResponsiveService.imageSize * 1.5,
          height: ResponsiveService.imageSize * 1.5,
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(
              ResponsiveService.borderRadiusMedium,
            ),
          ),
          child: Icon(
            Icons.person,
            color: AppColors.white,
            size: ResponsiveService.iconSizeXLarge * 1.5,
          ),
        ),
      ],
    );
  }
}