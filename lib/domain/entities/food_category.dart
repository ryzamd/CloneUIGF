import 'package:equatable/equatable.dart';

class FoodCategory extends Equatable {
  final String id;
  final String name;
  final String iconUrl;

  const FoodCategory({
    required this.id,
    required this.name,
    required this.iconUrl,
  });

  @override
  List<Object?> get props => [id, name, iconUrl];
}