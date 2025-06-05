import 'package:equatable/equatable.dart';

class DashboardViewModel extends Equatable {
  final List<ServiceItem> services;
  final List<PromoItem> promos;
  final List<DiscoverItem> discoverItems;
  final int rewardPoints;
  final bool hasPaymentMethod;
  final bool hasEmail;

  const DashboardViewModel({
    required this.services,
    required this.promos,
    required this.discoverItems,
    required this.rewardPoints,
    required this.hasPaymentMethod,
    required this.hasEmail,
  });

  factory DashboardViewModel.initial() {
    return const DashboardViewModel(
      services: [],
      promos: [],
      discoverItems: [],
      rewardPoints: 0,
      hasPaymentMethod: false,
      hasEmail: false,
    );
  }

  @override
  List<Object?> get props => [
        services,
        promos,
        discoverItems,
        rewardPoints,
        hasPaymentMethod,
        hasEmail,
      ];
}

class ServiceItem extends Equatable {
  final String id;
  final String name;
  final String iconPath;
  final ServiceType type;

  const ServiceItem({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.type,
  });

  @override
  List<Object?> get props => [id, name, iconPath, type];
}

enum ServiceType {
  bike,
  car,
  food,
  delivery,
  mart,
  voucher,
  gift,
  all,
}

class PromoItem extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String discount;

  const PromoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.discount,
  });

  @override
  List<Object?> get props => [id, title, description, imageUrl, discount];
}

class DiscoverItem extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final DiscoverType type;

  const DiscoverItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.type,
  });

  @override
  List<Object?> get props => [id, title, subtitle, imageUrl, type];
}

enum DiscoverType {
  deal,
  voucher,
  groupOrder,
  video,
}