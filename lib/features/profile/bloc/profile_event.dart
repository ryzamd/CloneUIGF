part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  const LoadProfile();
}

class UpdateTab extends ProfileEvent {
  final int tabIndex;

  const UpdateTab(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}

class NavigateToService extends ProfileEvent {
  final String serviceId;

  const NavigateToService(this.serviceId);

  @override
  List<Object?> get props => [serviceId];
}