import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class OrderTotalSection extends StatelessWidget {
  final int subtotal;
  final int deliveryFee;
  final int discount;
  final int total;
  final int savings;
  final VoidCallback onPlaceOrder;

  const OrderTotalSection({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    required this.savings,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: EdgeInsets.only(top: ResponsiveService.spacing8),
      padding: EdgeInsets.all(ResponsiveService.spacing16),
      child: Column(
        children: [
          _buildTotalRow('Tổng cộng', _formatPrice(total), isTotal: true),
          SizedBox(height: ResponsiveService.spacing8),
          if (savings > 0)
            Row(
              children: [
                ResponsiveText.caption(
                  text: 'Bạn tiết kiệm được ${_formatPrice(savings)} 🎉!',
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                ResponsiveText.caption(
                  text: _formatPrice(total + savings),
                  style: const TextStyle(
                    color: AppColors.textHint,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          SizedBox(height: ResponsiveService.spacing24),
          PrimaryButton(
            text: 'Đặt đơn',
            onPressed: onPlaceOrder,
            backgroundColor: AppColors.primaryGreen,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, {bool isTotal = false}) {
    return Row(
      children: [
        ResponsiveText.body(
          text: label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            fontSize: isTotal ? 18 : 14,
          ),
        ),
        const Spacer(),
        ResponsiveText.body(
          text: value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: isTotal ? 18 : 14,
          ),
        ),
      ],
    );
  }

  String _formatPrice(int price) {
    return '${(price / 1000).toStringAsFixed(0)}.000đ';
  }
}