import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../view_model/payment_view_model.dart';

class DeliveryOptionsSection extends StatelessWidget {
  final DeliveryOption selectedOption;
  final List<DeliveryOption> options;
  final Function(DeliveryOption) onOptionSelected;

  const DeliveryOptionsSection({
    super.key,
    required this.selectedOption,
    required this.options,
    required this.onOptionSelected,
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
            text: 'Tuỳ chọn giao hàng',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          SizedBox(height: ResponsiveService.spacing16),
          ...options.map((option) => _DeliveryOptionCard(
            option: option,
            isSelected: option.id == selectedOption.id,
            onTap: () => onOptionSelected(option),
          )),
        ],
      ),
    );
  }
}

class _DeliveryOptionCard extends StatelessWidget {
  final DeliveryOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _DeliveryOptionCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: ResponsiveService.spacing12),
        padding: EdgeInsets.all(ResponsiveService.spacing16),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : AppColors.lightGrey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusMedium),
        ),
        child: Row(
          children: [
            Icon(
              option.icon,
              color: isSelected ? AppColors.primaryGreen : AppColors.textSecondary,
              size: ResponsiveService.iconSizeMedium,
            ),
            SizedBox(width: ResponsiveService.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ResponsiveText.body(
                        text: option.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isSelected ? AppColors.primaryGreen : AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      ResponsiveText.body(
                        text: option.formattedPrice,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: isSelected ? AppColors.primaryGreen : AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  if (option.description.isNotEmpty) ...[
                    SizedBox(height: ResponsiveService.spacing4),
                    ResponsiveText.caption(
                      text: option.description,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}