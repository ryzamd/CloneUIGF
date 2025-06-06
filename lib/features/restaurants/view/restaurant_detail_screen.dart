import 'package:flutter/material.dart';
import '../../../core/core.dart';
import '../../../domain/entities/restaurant.dart';
import '../../../domain/entities/branch.dart';
import '../../../domain/entities/food_item.dart';
import '../../../data/datasources/dummy_restaurant_data.dart';
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
      body: CustomScrollView(
        slivers: [
          RestaurantImageHeader(
            restaurant: widget.restaurant,
            branch: widget.branch,
          ),
          
          // Restaurant Info
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
    );
  }

  void _onFoodItemTap(FoodItem item) {
    DialogService.showSuccess(
      title: 'Đã thêm vào giỏ',
      message: '${item.name} đã được thêm vào giỏ hàng',
    );
  }
}