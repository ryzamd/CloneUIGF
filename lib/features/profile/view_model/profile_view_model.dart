import 'package:cloneuigrabfood/features/dashboard/view_model/dashboard_view_model.dart';
import 'package:cloneuigrabfood/features/profile/view_model/offer_item_view_model.dart';
import 'package:equatable/equatable.dart';

class ProfileViewModel extends Equatable {
  final String userName;
  final String userAvatar;
  final int selectedTab;
  final int rewardPoints;
  final bool isGrabUnlimitedActive;
  final List<ServiceItem> services;
  final List<OfferItem> offers;

  const ProfileViewModel({
    required this.userName,
    required this.userAvatar,
    required this.selectedTab,
    required this.rewardPoints,
    required this.isGrabUnlimitedActive,
    required this.services,
    required this.offers,
  });

  factory ProfileViewModel.initial() {
    return const ProfileViewModel(
      userName: 'USER',
      userAvatar: '',
      selectedTab: 0,
      rewardPoints: 0,
      isGrabUnlimitedActive: false,
      services: [],
      offers: [],
    );
  }

  ProfileViewModel copyWith({
    String? userName,
    String? userAvatar,
    int? selectedTab,
    int? rewardPoints,
    bool? isGrabUnlimitedActive,
    List<ServiceItem>? services,
    List<OfferItem>? offers,
  }) {
    return ProfileViewModel(
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      selectedTab: selectedTab ?? this.selectedTab,
      rewardPoints: rewardPoints ?? this.rewardPoints,
      isGrabUnlimitedActive: isGrabUnlimitedActive ?? this.isGrabUnlimitedActive,
      services: services ?? this.services,
      offers: offers ?? this.offers,
    );
  }

  @override
  List<Object?> get props => [
        userName,
        userAvatar,
        selectedTab,
        rewardPoints,
        isGrabUnlimitedActive,
        services,
        offers,
      ];
}