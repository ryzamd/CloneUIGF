import 'package:flutter/material.dart';
import '../../../core/core.dart';
import '../../../domain/entities/restaurant.dart';
import '../../../domain/entities/branch.dart';
import 'widgets/branch_card.dart';

class BranchSelectionScreen extends StatelessWidget {
  final Restaurant restaurant;

  const BranchSelectionScreen({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: restaurant.name,
      backgroundColor: AppColors.backgroundGrey,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _RestaurantHeader(restaurant: restaurant),
            const SizedBox(height: 24),
            
            Text(
              'Chọn chi nhánh',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            Expanded(
              child: ListView.builder(
                itemCount: restaurant.branches.length,
                itemBuilder: (context, index) {
                  final branch = restaurant.branches[index];
                  return BranchCard(
                    branch: branch,
                    restaurant: restaurant,
                    onTap: () => _onBranchSelected(context, branch),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onBranchSelected(BuildContext context, Branch branch) {
    NavigationService.pushNamed(
      AppRoutes.restaurantDetail,
      arguments: RestaurantDetailArguments(
        restaurantId: restaurant,
        branchId: branch,
      ),
    );
  }
}

class _RestaurantHeader extends StatelessWidget {
  final Restaurant restaurant;

  const _RestaurantHeader({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Restaurant icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: _getImageColor(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getRestaurantIcon(),
              color: AppColors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          
          // Restaurant info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  restaurant.address,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColors.starYellow,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${restaurant.rating} (${restaurant.reviewCount})',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getImageColor() {
    switch (restaurant.id) {
      case 'lotteria':
        return const Color(0xFFE31E24);
      case 'highlands':
        return const Color(0xFF8B4513);
      default:
        return AppColors.primaryGreen;
    }
  }

  IconData _getRestaurantIcon() {
    if (restaurant.categories.contains('Cà Phê - Trà - Sinh Tố - Nước Ép')) {
      return Icons.local_cafe;
    } else if (restaurant.categories.contains('Thức ăn nhanh')) {
      return Icons.fastfood;
    }
    return Icons.restaurant;
  }
}