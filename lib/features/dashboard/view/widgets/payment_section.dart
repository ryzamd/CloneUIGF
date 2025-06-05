import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: _PaymentCard(
              title: 'Thanh toán',
              subtitle: 'Thêm thẻ',
              icon: Icons.credit_card,
              iconColor: AppColors.primaryGreen,
              onTap: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _PaymentCard(
              title: 'Tài khoản',
              subtitle: 'Thêm email',
              icon: Icons.email_outlined,
              iconColor: AppColors.primaryGreen,
              onTap: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _PaymentCard(
              title: 'GrabRewards',
              subtitle: '0',
              isRewards: true,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  final Color? iconColor;
  final bool isRewards;
  final VoidCallback onTap;

  const _PaymentCard({
    required this.title,
    required this.subtitle,
    this.icon,
    this.iconColor,
    this.isRewards = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.dividerColor,
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                if (icon != null) ...[
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: iconColor?.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 14,
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
                Expanded(
                  child: Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: isRewards ? 18 : 13,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}