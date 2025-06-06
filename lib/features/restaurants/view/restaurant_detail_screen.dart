import 'package:cloneuigrabfood/features/payment/view/widgets/payment_total_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/core.dart';
import '../../../domain/entities/restaurant.dart';
import '../../../domain/entities/branch.dart';
import '../../../domain/entities/food_item.dart';
import '../../../data/datasources/dummy_restaurant_data.dart';
import '../../cart/cubit/cart_cubit.dart';
import '../../cart/view/widgets/interactive_cart_bottom_sheet.dart';
import '../../payment/view/payment_screen.dart';
import 'widgets/restaurant_detail_widgets.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final Restaurant restaurant;
  final Branch branch;

  const RestaurantDetailScreen({
    super.key,
    required this.restaurant,
    required this.branch,
  });

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  List<FoodItem> _foodItems = [];
  List<FoodItem> _featuredItems = [];
  
  @override
  void initState() {
    super.initState();
    _loadFoodItems();
  }

  void _loadFoodItems() {
    _foodItems = DummyRestaurantData.getFoodItems(widget.restaurant.id);
    _featuredItems = _foodItems.where((item) => item.isBestSeller).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showAppBar: false,
      backgroundColor: AppColors.backgroundGrey,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              RestaurantImageHeader(
                restaurant: widget.restaurant,
                branch: widget.branch,
              ),
              
              SliverToBoxAdapter(
                child: RestaurantInfoSection(
                  restaurant: widget.restaurant,
                  branch: widget.branch,
                ),
              ),
              
              SliverToBoxAdapter(
                child: RestaurantActionButtons(),
              ),
              
              if (widget.restaurant.hasPromo)
                SliverToBoxAdapter(
                  child: PromoBannersSection(restaurant: widget.restaurant),
                ),
              
              if (_featuredItems.isNotEmpty)
                SliverToBoxAdapter(
                  child: FeaturedItemsSection(
                    items: _featuredItems,
                    onItemTap: _onFoodItemTap,
                  ),
                ),
              
              SliverToBoxAdapter(
                child: MenuSection(
                  items: _foodItems,
                  onItemTap: _onFoodItemTap,
                ),
              ),
            ],
          ),
          
          BlocBuilder<CartCubit, CartState>(
            builder: (context, cartState) {
              if (cartState.isEmpty) return const SizedBox.shrink();
              
              return Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: GestureDetector(
                  onTap: _showCartBottomSheet,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveService.spacing16,
                      vertical: ResponsiveService.spacing12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusMedium),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowMedium,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(ResponsiveService.spacing4),
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${cartState.itemCount}',
                            style: const TextStyle(
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: ResponsiveService.spacing12),
                        const Expanded(
                          child: Text(
                            'Xem giỏ hàng',
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          _formatPrice(cartState.subtotal),
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onFoodItemTap(FoodItem item) {
    context.read<CartCubit>().addItem(
      foodItem: item,
      restaurant: widget.restaurant,
      note: 'Chính sửa',
    );

    _showCartBottomSheet();
  }

  void _showCartBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ResponsiveService.borderRadiusLarge),
        ),
      ),
      builder: (modalContext) => BlocProvider.value(
        value: context.read<CartCubit>(),
        child: InteractiveCartBottomSheet(
          onAddMoreItems: () {
            Navigator.of(modalContext).pop();
          },
          onCheckout: () {
            Navigator.of(modalContext).pop();
            _navigateToPayment();
          },
        ),
      ),
    );
  }

  
  void _navigateToPayment() async {
    final result = await Navigator.of(context).push<PaymentResult>(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: context.read<CartCubit>(),
          child: const PaymentScreen(),
        ),
      ),
    );

    if (result == PaymentResult.success && mounted) {
      NavigationService.toRestaurants();
    }
  }

  String _formatPrice(int price) {
    return '${(price / 1000).toStringAsFixed(0)}.000đ';
  }
}