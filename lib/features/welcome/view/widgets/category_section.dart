import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
       final itemSize = ResponsiveService.isSmallScreen ? 52.0 : (ResponsiveService.isMediumScreen ? 64.0 : 80.0);
        
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: ResponsiveService.spacing8, ),
          child: ResponsiveService.isSmallScreen
              ? _buildCompactGrid(responsive, itemSize)
              : _buildSpacedRow(responsive, itemSize),
        );
      },
    );
  }

  Widget _buildCompactGrid(ResponsiveService responsive, double itemSize) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: ResponsiveService.spacing12,
      crossAxisSpacing: ResponsiveService.spacing12,
      childAspectRatio: 1,
      children: _buildCategoryItems(responsive, itemSize),
    );
  }

  Widget _buildSpacedRow(ResponsiveService responsive, double itemSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: _buildCategoryItems(responsive, itemSize),
    );
  }

  List<Widget> _buildCategoryItems(ResponsiveService responsive, double itemSize) {
    return [
      _CategoryItem(
        icon: Icons.two_wheeler,
        label: 'Xe máy',
        size: itemSize,
        responsive: responsive,
      ),
      _CategoryItem(
        icon: Icons.directions_car,
        label: 'Ô tô',
        size: itemSize,
        responsive: responsive,
      ),
      _CategoryItem(
        icon: Icons.restaurant,
        label: 'Đồ ăn',
        size: itemSize,
        responsive: responsive,
      ),
      _CategoryItem(
        icon: Icons.grid_view,
        label: 'Tất cả',
        size: itemSize,
        responsive: responsive,
      ),
    ];
  }
}

class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final double size;
  final ResponsiveService responsive;

  const _CategoryItem({
    required this.icon,
    required this.label,
    required this.size,
    required this.responsive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.lightGreen,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppColors.primaryGreen,
            size: ResponsiveService.iconSizeLarge,
          ),
        ),
        SizedBox(height: ResponsiveService.spacing8),
        ResponsiveText.caption(
          text: label,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}