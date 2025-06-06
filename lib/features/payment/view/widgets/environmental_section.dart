import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class EnvironmentalSection extends StatelessWidget {
  final bool isEnabled;
  final Function(bool) onToggle;

  const EnvironmentalSection({
    super.key,
    required this.isEnabled,
    required this.onToggle,
  });

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
                text: 'Thân thiện với môi trường',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: ResponsiveService.spacing16),
              
              _EnvironmentalOption(
                isEnabled: isEnabled,
                onToggle: onToggle,
              ),
              SizedBox(height: ResponsiveService.spacing12),
              
              ResponsiveText.caption(
                text: 'Xem cách thức hoạt động',
                style: const TextStyle(
                  color: AppColors.primaryGreen,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EnvironmentalOption extends StatelessWidget {
  final bool isEnabled;
  final Function(bool) onToggle;

  const _EnvironmentalOption({
    required this.isEnabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          padding: EdgeInsets.all(ResponsiveService.spacing16),
          decoration: BoxDecoration(
            border: Border.all(
              color: isEnabled ? AppColors.primaryGreen : AppColors.lightGrey,
            ),
            borderRadius: BorderRadius.circular(
              ResponsiveService.borderRadiusMedium,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.eco,
                color: AppColors.primaryGreen,
                size: ResponsiveService.iconSizeMedium,
              ),
              SizedBox(width: ResponsiveService.spacing12),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ResponsiveText.body(
                      text: 'Khoản đóng góp trung hòa các...',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: ResponsiveService.spacing4),
                    ResponsiveText.caption(
                      text: 'Giảm lượng khí thải các-bon trên mỗi chuyến đi và đơn đặt.',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: ResponsiveService.spacing12),
              
              // Price and Toggle
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveService.spacing8,
                      vertical: ResponsiveService.spacing4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.eco,
                          color: AppColors.primaryGreen,
                          size: 16,
                        ),
                        SizedBox(width: ResponsiveService.spacing4),
                        ResponsiveText.caption(
                          text: '1.000đ',
                          style: const TextStyle(
                            color: AppColors.primaryGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ResponsiveService.spacing8),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: isEnabled,
                      onChanged: onToggle,
                      activeColor: AppColors.primaryGreen,
                      activeTrackColor: AppColors.lightGreen,
                      inactiveThumbColor: AppColors.mediumGrey,
                      inactiveTrackColor: AppColors.lightGrey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}