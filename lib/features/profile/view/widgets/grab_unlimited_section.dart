import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class GrabUnlimitedSection extends StatelessWidget {
  const GrabUnlimitedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          color: AppColors.white,
          margin: EdgeInsets.only(top: ResponsiveService.spacing8),
          padding: EdgeInsets.all(ResponsiveService.spacing16),
          child: Container(
            padding: EdgeInsets.all(ResponsiveService.spacing16),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.orange),
              borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusMedium),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(ResponsiveService.spacing8),
                  decoration: const BoxDecoration(
                    color: AppColors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.all_inclusive,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
                SizedBox(width: ResponsiveService.spacing12),
                Expanded(
                  child: ResponsiveText.body(
                    text: 'Gói GrabUnlimited',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
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
      },
    );
  }
}