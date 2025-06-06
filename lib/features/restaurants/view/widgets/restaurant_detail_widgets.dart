// lib/features/restaurants/view/widgets/restaurant_detail_widgets.dart
import 'package:cloneuigrabfood/features/restaurants/view/widgets/food_item_cards.dart';
import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../../domain/entities/restaurant.dart';
import '../../../../domain/entities/branch.dart';
import '../../../../domain/entities/food_item.dart';

class RestaurantImageHeader extends StatelessWidget {
  final Restaurant restaurant;
  final Branch branch;

  const RestaurantImageHeader({
    super.key,
    required this.restaurant,
    required this.branch,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      leading: IconButton(
        onPressed: () => NavigationService.goBack(),
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
            size: 20,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.black54,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.favorite_border,
              color: AppColors.white,
              size: 20,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.delivery_dining,
                  color: AppColors.white,
                  size: 16,
                ),
                SizedBox(width: 4),
                Text(
                  'Giao hàng',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                _getRestaurantColor(),
                _getRestaurantColor().withValues(alpha: 0.8),
              ],
            ),
          ),
          child: Center(
            child: Icon(
              _getRestaurantIcon(),
              color: AppColors.white,
              size: 80,
            ),
          ),
        ),
      ),
    );
  }

  Color _getRestaurantColor() {
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

// Restaurant Info Section
class RestaurantInfoSection extends StatelessWidget {
  final Restaurant restaurant;
  final Branch branch;

  const RestaurantInfoSection({
    super.key,
    required this.restaurant,
    required this.branch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
          Text(
            branch.name,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          
          // Rating and delivery info
          Row(
            children: [
              const Icon(
                Icons.star,
                color: AppColors.starYellow,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '${restaurant.rating}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(${restaurant.reviewCount})',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          Row(
            children: [
              const Icon(
                Icons.local_shipping,
                color: AppColors.orange,
                size: 16,
              ),
              const SizedBox(width: 4),
              if (restaurant.deliveryFee < restaurant.originalDeliveryFee) ...[
                Text(
                  '${_formatPrice(restaurant.deliveryFee)}đ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '${_formatPrice(restaurant.originalDeliveryFee)}đ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textHint,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ] else ...[
                Text(
                  '${_formatPrice(restaurant.deliveryFee)}đ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              const SizedBox(width: 8),
              Text(
                '• ${restaurant.deliveryTime} phút trở lên',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatPrice(int price) {
    if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)}.000';
    }
    return price.toString();
  }
}

// Action Buttons Section
class RestaurantActionButtons extends StatelessWidget {
  const RestaurantActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: _ActionButton(
              icon: Icons.group,
              label: 'Đặt đơn nhóm',
              isSelected: true,
              onTap: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ActionButton(
              icon: Icons.schedule,
              label: 'Đặt giao sau',
              isSelected: false,
              onTap: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ActionButton(
              icon: Icons.share,
              label: 'Chia sẻ',
              isSelected: false,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ActionButton({
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
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.orange : AppColors.backgroundGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.white : AppColors.textSecondary,
              size: 16,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.white : AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Promo Banners Section
class PromoBannersSection extends StatelessWidget {
  final Restaurant restaurant;

  const PromoBannersSection({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _PromoBanner(
            title: 'Đăng ký GrabUnlimited',
            subtitle: 'Giảm đ15000 giao hàng',
            backgroundColor: AppColors.primaryGreen,
            icon: Icons.all_inclusive,
          ),
          const SizedBox(height: 12),
          _PromoBanner(
            title: 'Ưu đãi đến 10%',
            subtitle: 'Đặt đơn nhóm',
            backgroundColor: AppColors.orange,
            icon: Icons.group,
          ),
        ],
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final IconData icon;

  const _PromoBanner({
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.white,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.white,
            size: 16,
          ),
        ],
      ),
    );
  }
}

// Featured Items Section
class FeaturedItemsSection extends StatelessWidget {
  final List<FoodItem> items;
  final Function(FoodItem) onItemTap;

  const FeaturedItemsSection({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dành cho bạn',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  width: 180,
                  margin: EdgeInsets.only(right: index < items.length - 1 ? 12 : 0),
                  child: FoodItemHorizontalCard(
                    item: item,
                    onTap: () => onItemTap(item),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Menu Section
class MenuSection extends StatelessWidget {
  final List<FoodItem> items;
  final Function(FoodItem) onItemTap;

  const MenuSection({
    super.key,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'MENU',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Container(
                margin: EdgeInsets.only(bottom: index < items.length - 1 ? 16 : 0),
                child: FoodItemVerticalCard(
                  item: item,
                  onTap: () => onItemTap(item),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}