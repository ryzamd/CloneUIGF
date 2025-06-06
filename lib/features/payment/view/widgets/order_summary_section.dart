import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../view_model/payment_view_model.dart';

class OrderSummarySection extends StatelessWidget {
  final List<CartItemViewModel> items;
  final Function(CartItemViewModel) onAddItem;
  final Function(CartItemViewModel) onRemoveItem;

  const OrderSummarySection({
    super.key,
    required this.items,
    required this.onAddItem,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
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
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => _showAddMoreItems(context),
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
                itemCount: items.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: ResponsiveService.spacing12,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _CartItemCard(
                    item: item,
                    onAdd: () => onAddItem(item),
                    onRemove: () => onRemoveItem(item),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddMoreItems(BuildContext context) {
    NavigationService.goBack();
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItemViewModel item;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const _CartItemCard({
    required this.item,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Row(
          children: [
            // Food Image
            Container(
              width: ResponsiveService.responsive(
                mobile: 60.0,
                tablet: 70.0,
                desktop: 80.0,
              ),
              height: ResponsiveService.responsive(
                mobile: 60.0,
                tablet: 70.0,
                desktop: 80.0,
              ),
              decoration: BoxDecoration(
                color: _getFoodColor(),
                borderRadius: BorderRadius.circular(
                  ResponsiveService.borderRadiusMedium,
                ),
              ),
              child: Center(
                child: Icon(
                  _getFoodIcon(),
                  color: AppColors.white,
                  size: ResponsiveService.iconSizeLarge,
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
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: ResponsiveService.spacing4),
                  if (item.note.isNotEmpty) ...[
                    ResponsiveText.caption(
                      text: item.note,
                      style: const TextStyle(
                        color: AppColors.primaryGreen,
                      ),
                    ),
                    SizedBox(height: ResponsiveService.spacing4),
                  ],
                  ResponsiveText.body(
                    text: item.formattedPrice,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
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
                    onTap: onRemove,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveService.spacing12,
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
                    onTap: onAdd,
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
      },
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