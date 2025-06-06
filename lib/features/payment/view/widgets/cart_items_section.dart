import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../cart/cubit/cart_cubit.dart';

class CartItemsSection extends StatelessWidget {
  final CartState cartState;

  const CartItemsSection({
    super.key,
    required this.cartState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: EdgeInsets.only(top: ResponsiveService.spacing8),
      padding: EdgeInsets.all(ResponsiveService.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ResponsiveText.title(
                text: 'Tóm tắt đơn hàng',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => NavigationService.goBack(),
                child: ResponsiveText.body(
                  text: 'Thêm món',
                  style: const TextStyle(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveService.spacing16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartState.items.length,
            separatorBuilder: (context, index) => SizedBox(height: ResponsiveService.spacing12),
            itemBuilder: (context, index) {
              final item = cartState.items[index];
              return _PaymentCartItemCard(item: item);
            },
          ),
        ],
      ),
    );
  }
}

class _PaymentCartItemCard extends StatelessWidget {
  final CartItem item;

  const _PaymentCartItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Food Image
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: _getFoodColor(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              _getFoodIcon(),
              color: AppColors.white,
              size: 28,
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
                text: item.formattedPrice,
                style: const TextStyle(fontWeight: FontWeight.w600),
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
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.remove,
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: ResponsiveService.spacing12),
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
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: AppColors.white,
                    size: 20,
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