import 'package:cloneuigrabfood/core/constants/color_constant.dart';
import 'package:cloneuigrabfood/features/restaurants/view/widgets/category_filter_bottom_sheet.dart';
import 'package:cloneuigrabfood/features/restaurants/view/widgets/delivery_filter_bottom_sheet.dart';
import 'package:cloneuigrabfood/features/restaurants/view/widgets/sort_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:cloneuigrabfood/features/restaurants/view/widgets/filter_chip.dart' as custom;

class FilterChipsSection extends StatelessWidget {
  final String selectedSortFilter;
  final String selectedCategoryFilter;
  final String selectedDeliveryFilter;
  final Function({
    String? sortFilter,
    String? categoryFilter,
    String? deliveryFilter,
  }) onFilterChanged;

  const FilterChipsSection({
    super.key,
    required this.selectedSortFilter,
    required this.selectedCategoryFilter,
    required this.selectedDeliveryFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 5,
          children: [
            custom.FilterChip(
              icon: Icons.tune,
              label: 'Lọc theo',
              isSelected: selectedSortFilter.isNotEmpty,
              onTap: () => _showSortFilterSheet(context),
            ),
            custom.FilterChip(
              icon: Icons.restaurant_menu,
              label: 'Ăm thực',
              isSelected: selectedCategoryFilter.isNotEmpty,
              onTap: () => _showCategoryFilterSheet(context),
            ),
            custom.FilterChip(
              icon: Icons.delivery_dining,
              label: 'Phí giao hàng',
              isSelected: selectedDeliveryFilter.isNotEmpty,
              onTap: () => _showDeliveryFilterSheet(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SortFilterBottomSheet(
        selectedFilter: selectedSortFilter,
        onFilterSelected: (filter) {
          onFilterChanged(sortFilter: filter);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showCategoryFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CategoryFilterBottomSheet(
        selectedCategory: selectedCategoryFilter,
        onCategorySelected: (category) {
          onFilterChanged(categoryFilter: category);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showDeliveryFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => DeliveryFilterBottomSheet(
        selectedFilter: selectedDeliveryFilter,
        onFilterSelected: (filter) {
          onFilterChanged(deliveryFilter: filter);
          Navigator.pop(context);
        },
      ),
    );
  }
}