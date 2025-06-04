import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class FoodSection extends StatelessWidget {
  const FoodSection({super.key});

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
                'Món ngon cho bạn',
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
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              _FoodItem(
                icon: Icons.emoji_events,
                label: 'Bán chạy',
                iconColor: Colors.amber,
                backgroundColor: Color(0xFFFFF9E6),
              ),
              SizedBox(width: 16),
              _FoodItem(
                icon: Icons.local_offer,
                label: 'Đặc sản\nngon rẻ',
                iconColor: AppColors.primaryGreen,
                backgroundColor: Color(0xFFE8F5E8),
              ),
              SizedBox(width: 16),
              _FoodItem(
                icon: Icons.access_time,
                label: 'Gần đây',
                iconColor: Colors.blue,
                backgroundColor: Color(0xFFE6F2FF),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FoodItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color iconColor;
  final Color backgroundColor;

  const _FoodItem({
    required this.icon,
    required this.label,
    required this.iconColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 40,
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