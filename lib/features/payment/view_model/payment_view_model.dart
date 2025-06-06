import 'package:cloneuigrabfood/features/cart/cubit/cart_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PaymentViewModel extends Equatable {
  final String restaurantName;
  final String distance;
  final List<CartItemViewModel> cartItems;
  final bool isEnvironmentalEnabled;
  final DeliveryOption selectedDeliveryOption;
  final List<DeliveryOption> deliveryOptions;
  final PaymentMethod selectedPaymentMethod;
  final List<PaymentMethod> paymentMethods;
  final String deliveryAddress;
  final String? appliedPromotion;
  final int subtotal;
  final int deliveryFee;
  final int discount;
  final int total;
  final int savings;

  const PaymentViewModel({
    required this.restaurantName,
    required this.distance,
    required this.cartItems,
    required this.isEnvironmentalEnabled,
    required this.selectedDeliveryOption,
    required this.deliveryOptions,
    required this.selectedPaymentMethod,
    required this.paymentMethods,
    required this.deliveryAddress,
    this.appliedPromotion,
    required this.subtotal,
    required this.deliveryFee,
    required this.discount,
    required this.total,
    required this.savings,
  });

  factory PaymentViewModel.fromCartItems(List<CartItem> items) {
    final cartItemViewModels = items.map((item) => CartItemViewModel.fromCartItem(item)).toList();
    final subtotal = cartItemViewModels.fold<int>(0, (sum, item) => sum + item.totalPrice);
    
    return PaymentViewModel(
      restaurantName: items.first.restaurantName,
      distance: '6.3 km',
      cartItems: cartItemViewModels,
      isEnvironmentalEnabled: false,
      selectedDeliveryOption: DeliveryOption.fast(),
      deliveryOptions: DeliveryOption.getAll(),
      selectedPaymentMethod: PaymentMethod.cash(),
      paymentMethods: PaymentMethod.getAll(),
      deliveryAddress: 'Binh Loc Commune, Long Khanh City, Dong Nai',
      subtotal: subtotal,
      deliveryFee: 38000,
      discount: 9600,
      total: subtotal + 38000 - 9600 + 1000, // +1000 for environmental fee if enabled
      savings: 9600,
    );
  }

  PaymentViewModel addItem(CartItemViewModel item) {
    final existingIndex = cartItems.indexWhere((i) => i.id == item.id);
    List<CartItemViewModel> updatedItems;
    
    if (existingIndex >= 0) {
      updatedItems = List.from(cartItems);
      updatedItems[existingIndex] = updatedItems[existingIndex].incrementQuantity();
    } else {
      updatedItems = [...cartItems, item];
    }
    
    return _recalculateTotal(copyWith(cartItems: updatedItems));
  }

  PaymentViewModel removeItem(CartItemViewModel item) {
    final existingIndex = cartItems.indexWhere((i) => i.id == item.id);
    if (existingIndex < 0) return this;
    
    List<CartItemViewModel> updatedItems = List.from(cartItems);
    final currentItem = updatedItems[existingIndex];
    
    if (currentItem.quantity > 1) {
      updatedItems[existingIndex] = currentItem.decrementQuantity();
    } else {
      updatedItems.removeAt(existingIndex);
    }
    
    return _recalculateTotal(copyWith(cartItems: updatedItems));
  }

  PaymentViewModel toggleEnvironmental(bool isEnabled) {
    return _recalculateTotal(copyWith(isEnvironmentalEnabled: isEnabled));
  }

  PaymentViewModel selectDeliveryOption(DeliveryOption option) {
    return _recalculateTotal(copyWith(selectedDeliveryOption: option));
  }

  PaymentViewModel selectPaymentMethod(PaymentMethod method) {
    return copyWith(selectedPaymentMethod: method);
  }

  PaymentViewModel _recalculateTotal(PaymentViewModel vm) {
    final newSubtotal = vm.cartItems.fold<int>(0, (sum, item) => sum + item.totalPrice);
    final environmentalFee = vm.isEnvironmentalEnabled ? 1000 : 0;
    final newTotal = newSubtotal + vm.selectedDeliveryOption.price + environmentalFee - vm.discount;
    
    return vm.copyWith(
      subtotal: newSubtotal,
      deliveryFee: vm.selectedDeliveryOption.price,
      total: newTotal,
    );
  }

  PaymentViewModel copyWith({
    String? restaurantName,
    String? distance,
    List<CartItemViewModel>? cartItems,
    bool? isEnvironmentalEnabled,
    DeliveryOption? selectedDeliveryOption,
    List<DeliveryOption>? deliveryOptions,
    PaymentMethod? selectedPaymentMethod,
    List<PaymentMethod>? paymentMethods,
    String? deliveryAddress,
    String? appliedPromotion,
    int? subtotal,
    int? deliveryFee,
    int? discount,
    int? total,
    int? savings,
  }) {
    return PaymentViewModel(
      restaurantName: restaurantName ?? this.restaurantName,
      distance: distance ?? this.distance,
      cartItems: cartItems ?? this.cartItems,
      isEnvironmentalEnabled: isEnvironmentalEnabled ?? this.isEnvironmentalEnabled,
      selectedDeliveryOption: selectedDeliveryOption ?? this.selectedDeliveryOption,
      deliveryOptions: deliveryOptions ?? this.deliveryOptions,
      selectedPaymentMethod: selectedPaymentMethod ?? this.selectedPaymentMethod,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      appliedPromotion: appliedPromotion ?? this.appliedPromotion,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      savings: savings ?? this.savings,
    );
  }

  @override
  List<Object?> get props => [
        restaurantName,
        distance,
        cartItems,
        isEnvironmentalEnabled,
        selectedDeliveryOption,
        deliveryOptions,
        selectedPaymentMethod,
        paymentMethods,
        deliveryAddress,
        appliedPromotion,
        subtotal,
        deliveryFee,
        discount,
        total,
        savings,
      ];
}

class CartItemViewModel extends Equatable {
  final String id;
  final String name;
  final String note;
  final int price;
  final int quantity;

  const CartItemViewModel({
    required this.id,
    required this.name,
    required this.note,
    required this.price,
    required this.quantity,
  });

  factory CartItemViewModel.fromCartItem(CartItem item) {
    return CartItemViewModel(
      id: item.id,
      name: item.name,
      note: item.note,
      price: item.price,
      quantity: item.quantity,
    );
  }

  int get totalPrice => price * quantity;
  String get formattedPrice => '${(totalPrice / 1000).toStringAsFixed(0)}.000đ';

  CartItemViewModel incrementQuantity() {
    return copyWith(quantity: quantity + 1);
  }

  CartItemViewModel decrementQuantity() {
    return copyWith(quantity: quantity - 1);
  }

  CartItemViewModel copyWith({
    String? id,
    String? name,
    String? note,
    int? price,
    int? quantity,
  }) {
    return CartItemViewModel(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [id, name, note, price, quantity];
}

class DeliveryOption extends Equatable {
  final String id;
  final String name;
  final String description;
  final int price;
  final IconData icon;

  const DeliveryOption({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
  });

  String get formattedPrice => '${(price / 1000).toStringAsFixed(0)}.000đ';

  static DeliveryOption fast() => const DeliveryOption(
        id: 'fast',
        name: 'Nhanh',
        description: '25 phút',
        price: 33000,
        icon: Icons.flash_on,
      );

  static DeliveryOption economy() => const DeliveryOption(
        id: 'economy',
        name: 'Tiết kiệm',
        description: '40 phút',
        price: 29000,
        icon: Icons.savings,
      );

  static DeliveryOption scheduled() => const DeliveryOption(
        id: 'scheduled',
        name: 'Đặt giao sau',
        description: '',
        price: 0,
        icon: Icons.schedule,
      );

  static List<DeliveryOption> getAll() => [fast(), economy(), scheduled()];

  @override
  List<Object?> get props => [id, name, description, price, icon];
}

class PaymentMethod extends Equatable {
  final String id;
  final String name;
  final String subtitle;
  final IconData icon;
  final bool isActive;

  const PaymentMethod({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.isActive,
  });

  static PaymentMethod card() => const PaymentMethod(
        id: 'card',
        name: 'Thẻ',
        subtitle: 'Để xuất',
        icon: Icons.credit_card,
        isActive: false,
      );

  static PaymentMethod cash() => const PaymentMethod(
        id: 'cash',
        name: 'Tiền mặt',
        subtitle: '',
        icon: Icons.payments,
        isActive: true,
      );

  static List<PaymentMethod> getAll() => [card(), cash()];

  @override
  List<Object?> get props => [id, name, subtitle, icon, isActive];
}