import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../view_model/payment_view_model.dart';

class CartBottomSheet extends StatelessWidget {
  final List<CartItemViewModel> items;
  final int total;
  final VoidCallback onCancel;
  final VoidCallback onCheckout;

  const CartBottomSheet({
    super.key,
    required this.items,
    required this.total,
    required this.onCancel,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveService.spacing20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ResponsiveService.borderRadiusLarge),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(height: ResponsiveService.spacing20),

          // Title
          ResponsiveText.title(
            text: 'Giỏ hàng của bạn',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: ResponsiveService.spacing16),

          // Items
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: ResponsiveService.spacing8),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryGreen,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${item.quantity}',
                            style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: ResponsiveService.spacing12),
                      Expanded(
                        child: ResponsiveText.body(
                          text: item.name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      ResponsiveText.body(
                        text: item.formattedPrice,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          
          const Divider(),
          
          // Total
          Row(
            children: [
              ResponsiveText.title(
                text: 'Tổng cộng',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              ResponsiveText.title(
                text: _formatPrice(total),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveService.spacing24),

          // Buttons
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  text: 'Hủy',
                  type: ButtonType.outline,
                  onPressed: onCancel,
                ),
              ),
              SizedBox(width: ResponsiveService.spacing12),
              Expanded(
                child: PrimaryButton(
                  text: 'Thanh toán',
                  onPressed: onCheckout,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatPrice(int price) {
    return '${(price / 1000).toStringAsFixed(0)}.000đ';
  }

  static Future<void> show({
    required BuildContext context,
    required List<CartItemViewModel> items,
    required int total,
    required VoidCallback onCheckout,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ResponsiveService.borderRadiusLarge),
        ),
      ),
      builder: (context) => CartBottomSheet(
        items: items,
        total: total,
        onCancel: () async {
          final confirmed = await ConfirmDialog.show(
            context: context,
            title: 'Hủy đơn hàng',
            message: 'Bạn có chắc muốn hủy các món ăn đã chọn?',
            confirmText: 'Hủy đơn',
            cancelText: 'Tiếp tục',
            isDangerous: true,
          );
          
          if (confirmed == true && context.mounted) {
            Navigator.of(context).pop();
          }
        },
        onCheckout: () {
          Navigator.of(context).pop();
          onCheckout();
        },
      ),
    );
  }
}