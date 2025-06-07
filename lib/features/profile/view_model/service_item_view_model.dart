import 'package:equatable/equatable.dart';

class ServiceItem extends Equatable {
  final String id;
  final String title;
  final String description;

  const ServiceItem({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [id, title, description];
}