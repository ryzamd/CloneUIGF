import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class SortFilterBottomSheet extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const SortFilterBottomSheet({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          
          Text(
            'Lọc theo',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          FilterOption(
            title: 'Được đề xuất',
            isSelected: selectedFilter == 'recommended',
            onTap: () => onFilterSelected('recommended'),
          ),
          FilterOption(
            title: 'Đánh giá',
            isSelected: selectedFilter == 'rating',
            onTap: () => onFilterSelected('rating'),
          ),
          FilterOption(
            title: 'Phí giao hàng',
            isSelected: selectedFilter == 'delivery_fee',
            onTap: () => onFilterSelected('delivery_fee'),
          ),
          FilterOption(
            title: 'Thời gian giao hàng',
            isSelected: selectedFilter == 'delivery_time',
            onTap: () => onFilterSelected('delivery_time'),
          ),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class FilterOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterOption({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            if (isSelected)
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: AppColors.primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.white,
                  size: 14,
                ),
              )
            else
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.lightGrey),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}