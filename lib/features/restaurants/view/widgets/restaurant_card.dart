// lib/features/restaurants/view/widgets/restaurant_card.dart
import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../../domain/entities/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final VoidCallback onTap;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Restaurant Image
              _RestaurantImage(restaurant: restaurant),
              const SizedBox(width: 12),

              // Restaurant Info
              Expanded(child: _RestaurantInfo(restaurant: restaurant)),

              // Promo Badge
              if (restaurant.hasPromo)
                _PromoBadge(promoText: restaurant.promoText!),
            ],
          ),
        ),
      ),
    );
  }
}

class _RestaurantImage extends StatelessWidget {
  final Restaurant restaurant;

  const _RestaurantImage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: _getImageColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Icon(_getRestaurantIcon(), color: AppColors.white, size: 32),
      ),
    );
  }

  Color _getImageColor() {
    switch (restaurant.id) {
      case 'lotteria':
        return const Color(0xFFE31E24);
      case 'highlands':
        return const Color(0xFF8B4513);
      case 'bunbo_hue':
        return const Color(0xFFFF6B35);
      case 'chan_ga_dinh':
        return const Color(0xFF2E7D32);
      case 'zen_tea':
        return const Color(0xFF4CAF50);
      default:
        return AppColors.primaryGreen;
    }
  }

  IconData _getRestaurantIcon() {
    if (restaurant.categories.contains('Cà Phê - Trà - Sinh Tố - Nước Ép') ||
        restaurant.categories.contains('Cà Phê - Trà - Sinh Tố')) {
      return Icons.local_cafe;
    } else if (restaurant.categories.contains('Thức ăn nhanh')) {
      return Icons.fastfood;
    } else if (restaurant.categories.contains('Mì')) {
      return Icons.ramen_dining;
    } else if (restaurant.categories.contains('Đồ ăn nhe')) {
      return Icons.lunch_dining;
    }
    return Icons.restaurant;
  }
}

class _RestaurantInfo extends StatelessWidget {
  final Restaurant restaurant;

  const _RestaurantInfo({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Restaurant Name
        Text(
          restaurant.name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),

        // Rating and Reviews
        Row(
          children: [
            const Icon(Icons.star, color: AppColors.starYellow, size: 16),
            const SizedBox(width: 4),
            Text(
              '${restaurant.rating}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '(${restaurant.reviewCount})',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '• ${restaurant.address}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Delivery Info
        Row(
          children: [
            const Icon(Icons.local_shipping, color: AppColors.orange, size: 16),
            const SizedBox(width: 4),
            if (restaurant.deliveryFee < restaurant.originalDeliveryFee) ...[
              Text(
                '${_formatPrice(restaurant.deliveryFee)}đ',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '${_formatPrice(restaurant.originalDeliveryFee)}đ',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textHint,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ] else ...[
              Text(
                '${_formatPrice(restaurant.deliveryFee)}đ',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            
          ],
        ),
        const SizedBox(height: 6),
        Text(
          '${restaurant.deliveryTime} phút trở lên',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  String _formatPrice(int price) {
    if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}.000';
    }
    return price.toString();
  }
}

class _PromoBadge extends StatelessWidget {
  final String promoText;

  const _PromoBadge({required this.promoText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_offer, color: AppColors.white, size: 12),
          const SizedBox(width: 4),
          Text(
            promoText,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
