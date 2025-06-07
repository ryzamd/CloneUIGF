import 'package:equatable/equatable.dart';

class OfferItem extends Equatable {
  final String id;
  final String title;
  final String value;
  final bool isNew;

  const OfferItem({
    required this.id,
    required this.title,
    required this.value,
    required this.isNew,
  });

  @override
  List<Object?> get props => [id, title, value, isNew];
}