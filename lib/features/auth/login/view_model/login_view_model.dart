import 'package:equatable/equatable.dart';
import '../domain/entities/user.dart';

class UserViewModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? avatarUrl;

  const UserViewModel({
    required this.id,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.avatarUrl,
  });

  factory UserViewModel.fromEntity(User user) {
    return UserViewModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phoneNumber: user.phoneNumber,
      avatarUrl: user.avatarUrl,
    );
  }

  @override
  List<Object?> get props => [id, name, email, phoneNumber, avatarUrl];
}