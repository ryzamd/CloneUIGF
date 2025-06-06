import 'package:equatable/equatable.dart';

class Branch extends Equatable {
  final String id;
  final String name;
  final String address;
  final bool isOpen;
  final String? closingTime;

  const Branch({
    required this.id,
    required this.name,
    required this.address,
    required this.isOpen,
    this.closingTime,
  });

  @override
  List<Object?> get props => [id, name, address, isOpen, closingTime];
}