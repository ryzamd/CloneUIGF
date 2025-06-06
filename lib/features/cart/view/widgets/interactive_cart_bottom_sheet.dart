import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../cubit/cart_cubit.dart';

class InteractiveCartBottomSheet extends StatelessWidget {
  final VoidCallback onAddMoreItems;
  final VoidCallback onCheckout;

  const InteractiveCartBottomSheet({
    super.key,
    required this.onAddMoreItems,
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
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, cartState) {
          if (cartState.isEmpty) {
            return _buildEmptyCart(context);
          }

          return Column(
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

              // Header with add more button
              Row(
                children: [
                  ResponsiveText.title(
                    text: 'Giỏ hàng (${cartState.itemCount})',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: onAddMoreItems,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveService.spacing12,
                        vertical: ResponsiveService.spacing8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryGreen),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add,
                            color: AppColors.primaryGreen,
                            size: 16,
                          ),
                          SizedBox(width: ResponsiveService.spacing4),
                          ResponsiveText.caption(
                            text: 'Thêm món',
                            style: const TextStyle(
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ResponsiveService.spacing16),

              // Items list
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: cartState.items.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: ResponsiveService.spacing12,
                  ),
                  itemBuilder: (context, index) {
                    final item = cartState.items[index];
                    return _CartItemRow(item: item);
                  },
                ),
              ),

              const Divider(height: 32),

              // Total
              Row(
                children: [
                  ResponsiveText.title(
                    text: 'Tổng cộng',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ResponsiveText.title(
                    text: _formatPrice(cartState.subtotal),
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
                      onPressed: () => _showCancelConfirmation(context),
                    ),
                  ),
                  SizedBox(width: ResponsiveService.spacing12),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Thanh toán',
                      onPressed: () {
                        Navigator.of(context).pop();
                        onCheckout();
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(height: ResponsiveService.spacing32),
        Icon(
          Icons.shopping_cart_outlined,
          size: 64,
          color: AppColors.mediumGrey,
        ),
        SizedBox(height: ResponsiveService.spacing16),
        ResponsiveText.title(
          text: 'Giỏ hàng trống',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: ResponsiveService.spacing8),
        ResponsiveText.body(
          text: 'Thêm món ăn để bắt đầu đặt hàng',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        SizedBox(height: ResponsiveService.spacing24),
        PrimaryButton(
          text: 'Thêm món',
          onPressed: () {
            Navigator.of(context).pop();
            onAddMoreItems();
          },
        ),
        SizedBox(height: ResponsiveService.spacing20),
      ],
    );
  }

  void _showCancelConfirmation(BuildContext context) async {
    final confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Hủy đơn hàng',
      message: 'Bạn có chắc muốn hủy tất cả món ăn đã chọn?',
      confirmText: 'Hủy đơn',
      cancelText: 'Tiếp tục',
      isDangerous: true,
    );

    if (confirmed == true && context.mounted) {
      context.read<CartCubit>().clearCart();
      Navigator.of(context).pop();
    }
  }

  String _formatPrice(int price) {
    return '${(price / 1000).toStringAsFixed(0)}.000đ';
  }

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onAddMoreItems,
    required VoidCallback onCheckout,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ResponsiveService.borderRadiusLarge),
        ),
      ),
      builder: (context) => InteractiveCartBottomSheet(
        onAddMoreItems: onAddMoreItems,
        onCheckout: onCheckout,
      ),
    );
  }
}

class _CartItemRow extends StatelessWidget {
  final CartItem item;

  const _CartItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Food Image
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: _getFoodColor(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              _getFoodIcon(),
              color: AppColors.white,
              size: 24,
            ),
          ),
        ),
        SizedBox(width: ResponsiveService.spacing12),

        // Food Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveText.body(
                text: item.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              if (item.note.isNotEmpty) ...[
                SizedBox(height: ResponsiveService.spacing4),
                ResponsiveText.caption(
                  text: item.note,
                  style: const TextStyle(color: AppColors.primaryGreen),
                ),
              ],
              SizedBox(height: ResponsiveService.spacing4),
              ResponsiveText.body(
                text: item.formattedUnitPrice,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),

        // Quantity Controls
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryGreen),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => context.read<CartCubit>().decrementItem(item.id),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: AppColors.white,
                    size: 16,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveService.spacing8,
                ),
                child: ResponsiveText.body(
                  text: '${item.quantity}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.read<CartCubit>().incrementItem(item.id),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: AppColors.white,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getFoodColor() {
    if (item.name.toLowerCase().contains('gà')) {
      return const Color(0xFF2E7D32);
    } else if (item.name.toLowerCase().contains('bò')) {
      return const Color(0xFFFF6B35);
    }
    return AppColors.primaryGreen;
  }

  IconData _getFoodIcon() {
    if (item.name.toLowerCase().contains('gà')) {
      return Icons.lunch_dining;
    } else if (item.name.toLowerCase().contains('bò')) {
      return Icons.ramen_dining;
    }
    return Icons.restaurant_menu;
  }
}