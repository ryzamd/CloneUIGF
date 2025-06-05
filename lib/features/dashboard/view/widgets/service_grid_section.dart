import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class ServiceGridSection extends StatelessWidget {
  const ServiceGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _ServiceItem(
                icon: Icons.two_wheeler,
                label: 'Xe máy',
                iconColor: AppColors.primaryGreen,
              ),
              _ServiceItem(
                icon: Icons.directions_car,
                label: 'Ô tô',
                iconColor: AppColors.primaryGreen,
              ),
              _ServiceItem(
                icon: Icons.restaurant,
                label: 'Đồ ăn',
                iconColor: AppColors.orange,
                isFood: true,
              ),
              _ServiceItem(
                icon: Icons.local_shipping,
                label: 'Giao hàng',
                iconColor: AppColors.orange,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _ServiceItem(
                icon: Icons.shopping_basket,
                label: 'Đi chợ',
                iconColor: AppColors.primaryGreen,
              ),
              _ServiceItem(
                icon: Icons.percent,
                label: 'Voucher Nh...',
                iconColor: AppColors.orange,
              ),
              _ServiceItem(
                icon: Icons.card_giftcard,
                label: 'Quà tặng',
                iconColor: AppColors.primaryGreen,
              ),
              _ServiceItem(
                icon: Icons.grid_view,
                label: 'Tất cả',
                iconColor: AppColors.primaryGreen,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final bool isFood;

  const _ServiceItem({
    required this.icon,
    required this.label,
    required this.iconColor,
    this.isFood = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isFood) {
          NavigationService.toRestaurants();
        }
      },
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.backgroundGrey,
                borderRadius: BorderRadius.circular(16),
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
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}