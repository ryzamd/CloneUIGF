import 'package:equatable/equatable.dart';

class PaymentMethodItem extends Equatable {
  final String id;
  final String type; // 'visa', 'mastercard', 'amex'
  final String lastFourDigits;
  final bool isDefault;

  const PaymentMethodItem({
    required this.id,
    required this.type,
    required this.lastFourDigits,
    required this.isDefault,
  });
  
  @override
  List<Object?> get props => [id, type, lastFourDigits, isDefault];
}