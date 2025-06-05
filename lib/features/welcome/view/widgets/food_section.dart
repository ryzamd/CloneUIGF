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
              const Icon(Icons.arrow_forward, color: AppColors.black),
            ],
          ),
        ),
        SizedBox(height: 5),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _FoodItem(
                image: _FoodImage(
                  icon: Icons.star_border_rounded,
                  textTitle: "Bán chạy",
                  backgroundColor: Colors.grey.shade200,
                  iconColor: Colors.green,
                  secondaryColor: Colors.black,
                ),
              ),
              SizedBox(width: 16),
              _FoodItem(
                image: _FoodImage(
                  icon: Icons.restaurant_menu_rounded,
                  textTitle: "Đặc sản \nngon rẻ",
                  backgroundColor: Colors.grey.shade200,
                  iconColor: Colors.red,
                  secondaryColor: Colors.black,
                ),
              ),
              SizedBox(width: 16),
              _FoodItem(
                image: _FoodImage(
                  icon: Icons.list_rounded,
                  textTitle: "Gần đây",
                  backgroundColor: Colors.grey.shade200,
                  iconColor: AppColors.primaryGreen,
                  secondaryColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FoodItem extends StatelessWidget {
  final Widget image;

  const _FoodItem({required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: AppColors.shadowLight, blurRadius: 4)],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: image,
          ),
        ),
      ],
    );
  }
}

class _FoodImage extends StatelessWidget {
  final IconData icon;
  final String? textTitle;
  final Color backgroundColor;
  final Color iconColor;
  final Color? secondaryColor;

  const _FoodImage({
    required this.icon,
    this.textTitle,
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
            right: 5,
            bottom: 5,
            child: Icon(icon, color: iconColor, size: 40),
          ),
          if (textTitle != null)
            Positioned(
              left: 10,
              top: 5,
              child: Text(
                textTitle!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: secondaryColor ?? iconColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
        ],
      ),
    );
  }
}