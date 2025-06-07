part of 'logout_bloc.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();

  @override
  List<Object?> get props => [];
}

class LoadLogoutProfile extends LogoutEvent {
  const LoadLogoutProfile();
}

class UpdatePersonalInfo extends LogoutEvent {
  final String? name;
  final String? phone;
  final String? email;
  final String? gender;

  const UpdatePersonalInfo({
    this.name,
    this.phone,
    this.email,
    this.gender,
  });

  @override
  List<Object?> get props => [name, phone, email, gender];
}

class ToggleLinkedAccount extends LogoutEvent {
  final String platform;
  final bool isLinked;

  const ToggleLinkedAccount({
    required this.platform,
    required this.isLinked,
  });

  @override
  List<Object?> get props => [platform, isLinked];
}

class UpdateAvatar extends LogoutEvent {
  final String avatarUrl;

  const UpdateAvatar(this.avatarUrl);

  @override
  List<Object?> get props => [avatarUrl];
}