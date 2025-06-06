import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import 'sort_filter_bottom_sheet.dart'; // Import FilterOption

class DeliveryFilterBottomSheet extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  const DeliveryFilterBottomSheet({
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
            'Phí giao hàng',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          FilterOption(
            title: 'Tất cả',
            isSelected: selectedFilter == 'all',
            onTap: () => onFilterSelected('all'),
          ),
          FilterOption(
            title: 'Thấp hơn 15.000đ',
            isSelected: selectedFilter == 'under_15k',
            onTap: () => onFilterSelected('under_15k'),
          ),
          FilterOption(
            title: 'Thấp hơn 20.000đ',
            isSelected: selectedFilter == 'under_20k',
            onTap: () => onFilterSelected('under_20k'),
          ),
          FilterOption(
            title: 'Thấp hơn 25.000đ',
            isSelected: selectedFilter == 'under_25k',
            onTap: () => onFilterSelected('under_25k'),
          ),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}