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
                color: AppColors.black,
              ),
            ],
          ),
        ),
        SizedBox(height: 5,),
        SizedBox(
          height: 160,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              _ShoppingItem(
                image: _FoodImage(
                  icon: Icons.eco,
                  textTitle: "Thực phẩm \ntươi",
                  backgroundColor: Colors.grey.shade200,
                  iconColor: Colors.green,
                  secondaryColor: Colors.black,
                ),
              ),
              SizedBox(width: 16),
              _ShoppingItem(
                image: _FoodImage(
                  icon: Icons.set_meal,
                  textTitle: "Thịt Hải và \nsản",
                  backgroundColor: Colors.grey.shade200,
                  iconColor: Colors.red,
                  secondaryColor: Colors.black,
                ),
              ),
              SizedBox(width: 16),
              _ShoppingItem(
                image: _FoodImage(
                  icon: Icons.arrow_forward_sharp,
                  textTitle: "Vào Grab\nMart",
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

class _ShoppingItem extends StatelessWidget {
  final Widget image;

  const _ShoppingItem({
    required this.image,
  });

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
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 4,
              ),
            ],
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
            child: Icon(
              icon,
              color: iconColor,
              size: 40,
            ),
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
                  fontSize: 16
                )
              ),
            ),
        ],
      ),
    );
  }
}