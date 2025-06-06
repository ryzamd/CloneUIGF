import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class CategoryFilterBottomSheet extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryFilterBottomSheet({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              'Ẩm thực',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: [
                CategoryItem(
                  icon: Icons.rice_bowl,
                  label: 'Cơm',
                  isSelected: selectedCategory == 'Cơm',
                  onTap: () => onCategorySelected('Cơm'),
                ),
                CategoryItem(
                  icon: Icons.local_cafe,
                  label: 'Cà Phê - Trà - Sinh Tố - Nước Ép',
                  isSelected:
                      selectedCategory == 'Cà Phê - Trà - Sinh Tố - Nước Ép',
                  onTap: () =>
                      onCategorySelected('Cà Phê - Trà - Sinh Tố - Nước Ép'),
                ),
                CategoryItem(
                  icon: Icons.emoji_food_beverage,
                  label: 'Trà sữa',
                  isSelected: selectedCategory == 'Trà sữa',
                  onTap: () => onCategorySelected('Trà sữa'),
                ),
                CategoryItem(
                  icon: Icons.lunch_dining,
                  label: 'Đồ ăn nhe',
                  isSelected: selectedCategory == 'Đồ ăn nhe',
                  onTap: () => onCategorySelected('Đồ ăn nhe'),
                ),
                CategoryItem(
                  icon: Icons.public,
                  label: 'Món Quốc Tế',
                  isSelected: selectedCategory == 'Món Quốc Tế',
                  onTap: () => onCategorySelected('Món Quốc Tế'),
                ),
                CategoryItem(
                  icon: Icons.fastfood,
                  label: 'Thức ăn nhanh',
                  isSelected: selectedCategory == 'Thức ăn nhanh',
                  onTap: () => onCategorySelected('Thức ăn nhanh'),
                ),
                CategoryItem(
                  icon: Icons.outdoor_grill,
                  label: 'Lẩu & Nướng - Quay',
                  isSelected: selectedCategory == 'Lẩu & Nướng - Quay',
                  onTap: () => onCategorySelected('Lẩu & Nướng - Quay'),
                ),
                CategoryItem(
                  icon: Icons.breakfast_dining,
                  label: 'Bánh Mì - Xôi',
                  isSelected: selectedCategory == 'Bánh Mì - Xôi',
                  onTap: () => onCategorySelected('Bánh Mì - Xôi'),
                ),
                CategoryItem(
                  icon: Icons.cake,
                  label: 'Tráng miệng',
                  isSelected: selectedCategory == 'Tráng miệng',
                  onTap: () => onCategorySelected('Tráng miệng'),
                ),
                CategoryItem(
                  icon: Icons.eco,
                  label: 'Đồ ăn Healthy',
                  isSelected: selectedCategory == 'Đồ ăn Healthy',
                  onTap: () => onCategorySelected('Đồ ăn Healthy'),
                ),
                CategoryItem(
                  icon: Icons.more_horiz,
                  label: 'Món Khác',
                  isSelected: selectedCategory == 'Món Khác',
                  onTap: () => onCategorySelected('Món Khác'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryItem({
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
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightGreen : AppColors.white,
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : AppColors.lightGrey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:
                  isSelected ? AppColors.primaryGreen : AppColors.textSecondary,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isSelected
                    ? AppColors.primaryGreen
                    : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}