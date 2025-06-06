import 'package:cloneuigrabfood/core/constants/color_constant.dart';
import 'package:flutter/material.dart';

class FilterChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterChip({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGreen : AppColors.white,
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : AppColors.lightGrey,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? AppColors.white : AppColors.textSecondary,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? AppColors.white : AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down,
              size: 16,
              color: isSelected ? AppColors.white : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}