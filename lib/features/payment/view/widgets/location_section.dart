import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class LocationSection extends StatelessWidget {
  final String address;
  final VoidCallback onAddressChange;

  const LocationSection({
    super.key,
    required this.address,
    required this.onAddressChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: EdgeInsets.only(top: ResponsiveService.spacing8),
      padding: EdgeInsets.all(ResponsiveService.spacing16),
      child: Column(
        children: [
          // Warning Message
          Container(
            padding: EdgeInsets.all(ResponsiveService.spacing12),
            decoration: BoxDecoration(
              color: AppColors.warning.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusMedium),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.warning,
                  size: ResponsiveService.iconSizeMedium,
                ),
                SizedBox(width: ResponsiveService.spacing12),
                Expanded(
                  child: ResponsiveText.caption(
                    text: 'Vui lòng đảm bảo địa chỉ giao hàng chính xác',
                    style: const TextStyle(color: AppColors.warning),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: ResponsiveService.spacing16),
          
          GestureDetector(
            onTap: onAddressChange,
            child: Container(
              padding: EdgeInsets.all(ResponsiveService.spacing16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightGrey),
                borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusMedium),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.error,
                    size: ResponsiveService.iconSizeMedium,
                  ),
                  SizedBox(width: ResponsiveService.spacing12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ResponsiveText.body(
                          text: 'Binh Loc Commune',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: ResponsiveService.spacing4),
                        ResponsiveText.caption(
                          text: address,
                          style: const TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.mediumGrey,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}