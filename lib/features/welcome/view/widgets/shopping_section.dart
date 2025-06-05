import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class ShoppingSection extends StatelessWidget {
  const ShoppingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Đi chợ mua sắm',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(
                Icons.arrow_forward,
                color: AppColors.primaryGreen,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              _ShoppingItem(
                label: 'Thực phẩm\ntươi',
                image: _FoodImage(
                  icon: Icons.eco,
                  secondaryIcon: Icons.apple,
                  backgroundColor: Color(0xFFFFF4E6),
                  iconColor: Colors.green,
                  secondaryColor: Colors.orange,
                ),
              ),
              SizedBox(width: 16),
              _ShoppingItem(
                label: 'Thịt và\nhải sản',
                image: _FoodImage(
                  icon: Icons.set_meal,
                  secondaryIcon: Icons.restaurant,
                  backgroundColor: Color(0xFFFFE6E6),
                  iconColor: Colors.red,
                  secondaryColor: Colors.blue,
                ),
              ),
              SizedBox(width: 16),
              _ShoppingItem(
                label: 'Vào\nGrabMart',
                image: _FoodImage(
                  icon: Icons.shopping_cart,
                  backgroundColor: Color(0xFFE6F2FF),
                  iconColor: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShoppingItem extends StatelessWidget {
  final String label;
  final Widget image;

  const _ShoppingItem({
    required this.label,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: image,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _FoodImage extends StatelessWidget {
  final IconData icon;
  final IconData? secondaryIcon;
  final Color backgroundColor;
  final Color iconColor;
  final Color? secondaryColor;

  const _FoodImage({
    required this.icon,
    this.secondaryIcon,
    required this.backgroundColor,
    required this.iconColor,
    this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          Positioned(
            left: 10,
            bottom: 10,
            child: Icon(
              icon,
              color: iconColor,
              size: 40,
            ),
          ),
          if (secondaryIcon != null)
            Positioned(
              right: 10,
              top: 10,
              child: Icon(
                secondaryIcon,
                color: secondaryColor ?? iconColor,
                size: 30,
              ),
            ),
        ],
      ),
    );
  }
}