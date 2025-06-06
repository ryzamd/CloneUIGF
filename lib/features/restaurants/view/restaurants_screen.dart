import 'package:flutter/material.dart';
import '../../../core/core.dart';
import '../../../data/datasources/dummy_restaurant_data.dart';
import '../../../domain/entities/restaurant.dart';
import 'widgets/widgets.dart';

class RestaurantsScreen extends StatefulWidget {
  const RestaurantsScreen({super.key});

  @override
  State<RestaurantsScreen> createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Restaurant> _restaurants = [];
  List<Restaurant> _filteredRestaurants = [];
  String _selectedSortFilter = '';
  String _selectedCategoryFilter = '';
  String _selectedDeliveryFilter = '';

  @override
  void initState() {
    super.initState();
    _loadRestaurants();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadRestaurants() {
    _restaurants = DummyRestaurantData.getRestaurants();
    _filteredRestaurants = _restaurants;
  }

  void _onSearchChanged() {
    _filterRestaurants();
  }

  void _filterRestaurants() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      _filteredRestaurants = _restaurants.where((restaurant) {
        final matchesSearch = restaurant.name.toLowerCase().contains(query) ||
            restaurant.address.toLowerCase().contains(query);
        
        final matchesCategory = _selectedCategoryFilter.isEmpty ||
            restaurant.categories.contains(_selectedCategoryFilter);
            
        return matchesSearch && matchesCategory;
      }).toList();

      if (_selectedSortFilter == 'rating') {
        _filteredRestaurants.sort((a, b) => b.rating.compareTo(a.rating));
      } else if (_selectedSortFilter == 'delivery_fee') {
        _filteredRestaurants.sort((a, b) => a.deliveryFee.compareTo(b.deliveryFee));
      } else if (_selectedSortFilter == 'delivery_time') {
        _filteredRestaurants.sort((a, b) => a.deliveryTime.compareTo(b.deliveryTime));
      }
    });
  }

  void _onFilterChanged({
    String? sortFilter,
    String? categoryFilter,
    String? deliveryFilter,
  }) {
    setState(() {
      if (sortFilter != null) _selectedSortFilter = sortFilter;
      if (categoryFilter != null) _selectedCategoryFilter = categoryFilter;
      if (deliveryFilter != null) _selectedDeliveryFilter = deliveryFilter;
    });
    _filterRestaurants();
  }

  void _onRestaurantTapped(Restaurant restaurant) {
    if (restaurant.hasMultipleBranches) {
      NavigationService.pushNamed(AppRoutes.branchSelection, arguments: restaurant);
    } else {
      NavigationService.pushNamed(
        AppRoutes.restaurantDetail,
        arguments: RestaurantDetailArguments(
          restaurantId: restaurant,
          branchId: restaurant.branches.first,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showAppBar: false,
      backgroundColor: AppColors.backgroundGrey,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => NavigationService.goBack(),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: RestaurantSearchHeader(
                    controller: _searchController,
                    onBackPressed: () => NavigationService.goBack(),
                  ),
                ),
              ],
            ),
            
            FilterChipsSection(
              selectedSortFilter: _selectedSortFilter,
              selectedCategoryFilter: _selectedCategoryFilter,
              selectedDeliveryFilter: _selectedDeliveryFilter,
              onFilterChanged: _onFilterChanged,
            ),
            
            Expanded(
              child: _filteredRestaurants.isEmpty
                  ? const EmptyStateWidget(
                      message: 'Không tìm thấy nhà hàng nào',
                      icon: Icons.restaurant_outlined,
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: _filteredRestaurants.length,
                      itemBuilder: (context, index) {
                        final restaurant = _filteredRestaurants[index];
                        return RestaurantCard(
                          restaurant: restaurant,
                          onTap: () => _onRestaurantTapped(restaurant),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}