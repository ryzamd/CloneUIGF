import 'package:cloneuigrabfood/domain/entities/branch.dart';
import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String address;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final int deliveryTime;
  final int deliveryFee;
  final int originalDeliveryFee;
  final List<String> categories;
  final List<Branch> branches;
  final bool isOpen;
  final bool hasPromo;
  final String? promoText;

  const Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.originalDeliveryFee,
    required this.categories,
    required this.branches,
    required this.isOpen,
    this.hasPromo = false,
    this.promoText,
  });

  bool get hasMultipleBranches => branches.length > 1;

  @override
  List<Object?> get props => [
        id,
        name,
        address,
        imageUrl,
        rating,
        reviewCount,
        deliveryTime,
        deliveryFee,
        originalDeliveryFee,
        categories,
        branches,
        isOpen,
        hasPromo,
        promoText,
      ];
}