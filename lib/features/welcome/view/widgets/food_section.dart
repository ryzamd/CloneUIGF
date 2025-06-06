import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class FoodSection extends StatelessWidget {
  const FoodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveService.spacing16,
                vertical: ResponsiveService.spacing8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ResponsiveText.title(
                    text: 'Món ngon cho bạn',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: AppColors.black,
                    size: ResponsiveService.iconSizeMedium,
                  ),
                ],
              ),
            ),
            SizedBox(height: ResponsiveService.spacing4),
            SizedBox(
              height: ResponsiveService.cardHeight,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: ResponsiveService.spacing16),
                children: [
                  _ResponsiveFoodItem(
                    image: _FoodImage(
                      icon: Icons.star_border_rounded,
                      textTitle: "Bán chạy",
                      backgroundColor: Colors.grey.shade200,
                      iconColor: Colors.green,
                      secondaryColor: Colors.black,
                      responsive: responsive,
                    ),
                    responsive: responsive,
                  ),
                  SizedBox(width: ResponsiveService.spacing16),
                  _ResponsiveFoodItem(
                    image: _FoodImage(
                      icon: Icons.restaurant_menu_rounded,
                      textTitle: "Đặc sản \nngon rẻ",
                      backgroundColor: Colors.grey.shade200,
                      iconColor: Colors.red,
                      secondaryColor: Colors.black,
                      responsive: responsive,
                    ),
                    responsive: responsive,
                  ),
                  SizedBox(width: ResponsiveService.spacing16),
                  _ResponsiveFoodItem(
                    image: _FoodImage(
                      icon: Icons.list_rounded,
                      textTitle: "Gần đây",
                      backgroundColor: Colors.grey.shade200,
                      iconColor: AppColors.primaryGreen,
                      secondaryColor: Colors.black,
                      responsive: responsive,
                    ),
                    responsive: responsive,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ResponsiveFoodItem extends StatelessWidget {
  final Widget image;
  final ResponsiveService responsive;

  const _ResponsiveFoodItem({
    required this.image,
    required this.responsive,
  });

  @override
  Widget build(BuildContext context) {
    final itemSize = ResponsiveService.responsive(
      mobile: 110.0,
      tablet: 130.0,
      desktop: 150.0,
    );

    return Column(
      children: [
        Container(
          width: itemSize,
          height: itemSize,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusLarge),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 4,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusLarge),
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
  final ResponsiveService responsive;

  const _FoodImage({
    required this.icon,
    this.textTitle,
    required this.backgroundColor,
    required this.iconColor,
    this.secondaryColor,
    required this.responsive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          Positioned(
            right: ResponsiveService.spacing4,
            bottom: ResponsiveService.spacing4,
            child: Icon(
              icon,
              color: iconColor,
              size: ResponsiveService.iconSizeXLarge,
            ),
          ),
          if (textTitle != null)
            Positioned(
              left: ResponsiveService.spacing8,
              top: ResponsiveService.spacing4,
              child: ResponsiveText.caption(
                text: textTitle!,
                style: TextStyle(
                  color: secondaryColor ?? iconColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}