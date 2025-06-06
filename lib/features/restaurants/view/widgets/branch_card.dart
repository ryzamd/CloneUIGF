import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../../../domain/entities/restaurant.dart';
import '../../../../domain/entities/branch.dart';

class BranchCard extends StatelessWidget {
  final Branch branch;
  final Restaurant restaurant;
  final VoidCallback onTap;

  const BranchCard({
    super.key,
    required this.branch,
    required this.restaurant,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: branch.isOpen ? onTap : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: branch.isOpen
              ? null
              : Border.all(color: AppColors.lightGrey),
          boxShadow: branch.isOpen
              ? [
                  BoxShadow(
                    color: AppColors.shadowLight,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Opacity(
          opacity: branch.isOpen ? 1.0 : 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      branch.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: branch.isOpen
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  _BranchStatusBadge(branch: branch),
                ],
              ),
              const SizedBox(height: 8),
              
              Text(
                branch.address,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              
              if (!branch.isOpen && branch.closingTime != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      color: AppColors.error,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      branch.closingTime!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
              
              if (branch.isOpen) ...[
                const SizedBox(height: 12),
                
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
                    const SizedBox(width: 8),
                    Text(
                      '• ${restaurant.deliveryTime} phút trở lên',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                
                if (restaurant.hasPromo) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.local_offer,
                              color: AppColors.white,
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              restaurant.promoText!,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Đơn hàng từ 40.000đ',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ],
          ),
        ),
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

class _BranchStatusBadge extends StatelessWidget {
  final Branch branch;

  const _BranchStatusBadge({required this.branch});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: branch.isOpen
            ? AppColors.lightGreen
            : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        branch.isOpen ? 'Mở cửa' : 'Đóng cửa',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: branch.isOpen
              ? AppColors.primaryGreen
              : AppColors.textHint,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}