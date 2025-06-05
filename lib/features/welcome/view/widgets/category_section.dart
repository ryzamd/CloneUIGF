import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _CategoryItem(
            icon: Icons.two_wheeler,
            label: 'Xe máy',
            backgroundColor: Color(0xFFE8F5E8),
            iconColor: AppColors.primaryGreen,
          ),
          _CategoryItem(
            icon: Icons.directions_car,
            label: 'Ô tô',
            backgroundColor: Color(0xFFE8F5E8),
            iconColor: AppColors.primaryGreen,
          ),
          _CategoryItem(
            icon: Icons.restaurant,
            label: 'Đồ ăn',
            backgroundColor: Color(0xFFE8F5E8),
            iconColor: AppColors.primaryGreen,
            isActive: true,
          ),
          _CategoryItem(
            icon: Icons.grid_view,
            label: 'Tất cả',
            backgroundColor: Color(0xFFE8F5E8),
            iconColor: AppColors.primaryGreen,
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color iconColor;
  final bool isActive;

  const _CategoryItem({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.iconColor,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: isActive
              ? Border.all(color: AppColors.primaryGreen, width: 2)
              : null,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isActive ? AppColors.primaryGreen : AppColors.textPrimary,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}