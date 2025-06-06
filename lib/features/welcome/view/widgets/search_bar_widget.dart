import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveService.spacing16,
          ),
          padding: EdgeInsets.symmetric(horizontal: ResponsiveService.spacing16),
          height: ResponsiveService.buttonHeightMedium,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusLarge),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: AppColors.mediumGrey,
                size: ResponsiveService.iconSizeMedium,
              ),
              SizedBox(width: ResponsiveService.spacing12),
              ResponsiveText.body(
                text: 'Tìm món ăn',
                style: const TextStyle(color: AppColors.textHint),
              ),
            ],
          ),
        );
      },
    );
  }
}