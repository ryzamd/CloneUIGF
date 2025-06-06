part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class LoadPayment extends PaymentEvent {
  final List<CartItem> cartItems;

  const LoadPayment(this.cartItems);

  @override
  List<Object?> get props => [cartItems];
}

class AddItemToCart extends PaymentEvent {
  final CartItemViewModel item;

  const AddItemToCart(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveItemFromCart extends PaymentEvent {
  final CartItemViewModel item;

  const RemoveItemFromCart(this.item);

  @override
  List<Object?> get props => [item];
}

class ToggleEnvironmental extends PaymentEvent {
  final bool isEnabled;

  const ToggleEnvironmental(this.isEnabled);

  @override
  List<Object?> get props => [isEnabled];
}

class SelectDeliveryOption extends PaymentEvent {
  final DeliveryOption option;

  const SelectDeliveryOption(this.option);

  @override
  List<Object?> get props => [option];
}

class SelectPaymentMethod extends PaymentEvent {
  final PaymentMethod method;

  const SelectPaymentMethod(this.method);

  @override
  List<Object?> get props => [method];
}

class PlaceOrder extends PaymentEvent {
  const PlaceOrder();
}