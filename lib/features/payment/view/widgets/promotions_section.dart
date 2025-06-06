import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class PromotionsSection extends StatelessWidget {
  final String? appliedPromo;
  final VoidCallback onApplyPromo;

  const PromotionsSection({
    super.key,
    this.appliedPromo,
    required this.onApplyPromo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: EdgeInsets.only(top: ResponsiveService.spacing8),
      padding: EdgeInsets.all(ResponsiveService.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveText.title(
            text: 'Ưu đãi',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: ResponsiveService.spacing16),
          GestureDetector(
            onTap: onApplyPromo,
            child: Container(
              padding: EdgeInsets.all(ResponsiveService.spacing16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightGrey),
                borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusMedium),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.local_offer,
                    color: AppColors.orange,
                    size: ResponsiveService.iconSizeMedium,
                  ),
                  SizedBox(width: ResponsiveService.spacing16),
                  Expanded(
                    child: ResponsiveText.body(
                      text: appliedPromo ?? 'Áp dụng ưu đãi để được giảm giá',
                      style: const TextStyle(fontWeight: FontWeight.w500),
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