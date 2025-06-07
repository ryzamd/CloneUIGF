import 'package:equatable/equatable.dart';

class LogoutViewModel extends Equatable {
  final String name;
  final String phone;
  final String email;
  final String gender;
  final String avatarUrl;
  final int rewardPoints;
  final bool isGrabPinEnabled;
  final Map<String, bool> linkedAccounts;

  const LogoutViewModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.gender,
    required this.avatarUrl,
    required this.rewardPoints,
    required this.isGrabPinEnabled,
    required this.linkedAccounts,
  });

  factory LogoutViewModel.initial() {
    return const LogoutViewModel(
      name: 'USER',
      phone: '0123456879',
      email: '',
      gender: 'Vui lòng chọn giới tính',
      avatarUrl: '',
      rewardPoints: 0,
      isGrabPinEnabled: true,
      linkedAccounts: {
        'google': true,
        'facebook': false,
      },
    );
  }

  LogoutViewModel copyWith({
    String? name,
    String? phone,
    String? email,
    String? gender,
    String? avatarUrl,
    int? rewardPoints,
    bool? isGrabPinEnabled,
    Map<String, bool>? linkedAccounts,
  }) {
    return LogoutViewModel(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rewardPoints: rewardPoints ?? this.rewardPoints,
      isGrabPinEnabled: isGrabPinEnabled ?? this.isGrabPinEnabled,
      linkedAccounts: linkedAccounts ?? this.linkedAccounts,
    );
  }

  @override
  List<Object?> get props => [
        name,
        phone,
        email,
        gender,
        avatarUrl,
        rewardPoints,
        isGrabPinEnabled,
        linkedAccounts,
      ];
}