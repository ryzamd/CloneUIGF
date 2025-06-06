import 'package:equatable/equatable.dart';

class FoodItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int price;
  final int originalPrice;
  final bool isAvailable;
  final bool isBestSeller;
  final String category;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.originalPrice,
    required this.isAvailable,
    required this.isBestSeller,
    required this.category,
  });

  bool get hasDiscount => originalPrice > price;
  int get discountAmount => originalPrice - price;

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imageUrl,
        price,
        originalPrice,
        isAvailable,
        isBestSeller,
        category,
      ];
}