import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../../domain/entities/food_item.dart';

class FoodItemHorizontalCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback onTap;

  const FoodItemHorizontalCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _getFoodColor(),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        _getFoodIcon(),
                        color: AppColors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  if (item.isBestSeller)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Bán chạy',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: onTap,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Food Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      _formatPrice(item.price),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getFoodColor() {
    switch (item.category) {
      case 'Bán chạy':
        return AppColors.orange;
      case 'MENU':
        return AppColors.primaryGreen;
      default:
        return AppColors.mediumGrey;
    }
  }

  IconData _getFoodIcon() {
    if (item.name.toLowerCase().contains('bún')) {
      return Icons.ramen_dining;
    } else if (item.name.toLowerCase().contains('cà phê')) {
      return Icons.local_cafe;
    } else if (item.name.toLowerCase().contains('trà')) {
      return Icons.emoji_food_beverage;
    }
    return Icons.restaurant_menu;
  }

  String _formatPrice(int price) {
    if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}.000';
    }
    return price.toString();
  }
}

// Vertical Food Item Card (for menu section)
class FoodItemVerticalCard extends StatelessWidget {
  final FoodItem item;
  final VoidCallback onTap;

  const FoodItemVerticalCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Row(
        children: [
          // Food Image
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: _getFoodColor(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Icon(
                    _getFoodIcon(),
                    color: AppColors.white,
                    size: 32,
                  ),
                ),
              ),
              if (item.isBestSeller)
                Positioned(
                  top: 4,
                  left: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Bán chạy',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          
          // Food Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (item.description.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  _formatPrice(item.price),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Add Button
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.primaryGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getFoodColor() {
    switch (item.category) {
      case 'Bán chạy':
        return AppColors.orange;
      case 'MENU':
        return AppColors.primaryGreen;
      default:
        return AppColors.mediumGrey;
    }
  }

  IconData _getFoodIcon() {
    if (item.name.toLowerCase().contains('bún')) {
      return Icons.ramen_dining;
    } else if (item.name.toLowerCase().contains('cà phê')) {
      return Icons.local_cafe;
    } else if (item.name.toLowerCase().contains('trà')) {
      return Icons.emoji_food_beverage;
    }
    return Icons.restaurant_menu;
  }

  String _formatPrice(int price) {
    if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}.000';
    }
    return price.toString();
  }
}