import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? phoneNumber;
  final String? avatarUrl;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.phoneNumber,
    this.avatarUrl,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    email,
    name,
    phoneNumber,
    avatarUrl,
    createdAt,
  ];
}