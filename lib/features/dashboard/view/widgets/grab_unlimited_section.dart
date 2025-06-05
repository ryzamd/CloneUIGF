import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class GrabUnlimitedSection extends StatelessWidget {
  const GrabUnlimitedSection({super.key});

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
            'Đặc quyền GrabUnlimited',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 240,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                _UnlimitedCard(
                  title: 'GrabUnlimited',
                  subtitle: 'Giảm 15.000đ phí ship\nđơn GrabFood',
                  description: 'Ăn ngon ít tốn ship',
                  discount: 'Giảm 15.000đ',
                  backgroundColor: AppColors.primaryGreen,
                ),
                SizedBox(width: 12),
                _UnlimitedCard(
                  title: 'GrabUnlimited',
                  subtitle: 'Luôn có ưu đãi\nmỗi chuyến GrabBike/Car',
                  description: 'Grab đón đưa, năng\nmua không ngại',
                  discount: 'Giảm 10%',
                  backgroundColor: AppColors.primaryGreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UnlimitedCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String discount;
  final Color backgroundColor;

  const _UnlimitedCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.discount,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.all_inclusive,
                  color: AppColors.primaryGreen,
                  size: 16,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          const Spacer(),
          Text(
            description,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  discount,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Xem thêm',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}