import 'package:flutter/material.dart';
import '../../../../../core/core.dart';

class BusinessAccountSection extends StatelessWidget {
  const BusinessAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          color: AppColors.white,
          margin: EdgeInsets.only(top: ResponsiveService.spacing8),
          padding: EdgeInsets.all(ResponsiveService.spacing16),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ResponsiveText.body(
                        text: 'Tạo hồ sơ doanh nghiệp',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.info,
                        ),
                      ),
                      SizedBox(height: ResponsiveService.spacing4),
                      ResponsiveText.caption(
                        text: 'Quản lý tốt hơn chi phí đi lại của bạn',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
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
      },
    );
  }
}