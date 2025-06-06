import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class PaymentHeader extends StatelessWidget {
  final String restaurantName;
  final String distance;

  const PaymentHeader({
    super.key,
    required this.restaurantName,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          color: AppColors.white,
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveService.spacing16,
            vertical: ResponsiveService.spacing12,
          ),
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => NavigationService.goBack(),
                  child: Container(
                    padding: EdgeInsets.all(ResponsiveService.spacing8),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: ResponsiveService.iconSizeMedium,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(width: ResponsiveService.spacing8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ResponsiveText.title(
                        text: restaurantName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: ResponsiveService.spacing4),
                      ResponsiveText.caption(
                        text: 'Cách bạn: $distance',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}