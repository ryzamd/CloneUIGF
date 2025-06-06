part of 'cart_cubit.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final bool isOrderSuccessful;

  const CartState({
    this.items = const [],
    this.isOrderSuccessful = false,
  });

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
  int get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  
  String? get restaurantId => items.isNotEmpty ? items.first.restaurantId : null;
  String? get restaurantName => items.isNotEmpty ? items.first.restaurantName : null;

  CartState copyWith({
    List<CartItem>? items,
    bool? isOrderSuccessful,
  }) {
    return CartState(
      items: items ?? this.items,
      isOrderSuccessful: isOrderSuccessful ?? this.isOrderSuccessful,
    );
  }

  @override
  List<Object?> get props => [items, isOrderSuccessful];
}

class CartItem extends Equatable {
  final String id;
  final String name;
  final int price;
  final int quantity;
  final String note;
  final String restaurantId;
  final String restaurantName;

  const CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.note,
    required this.restaurantId,
    required this.restaurantName,
  });

  int get totalPrice => price * quantity;

  String get formattedPrice => '${(totalPrice / 1000).toStringAsFixed(0)}.000đ';
  String get formattedUnitPrice => '${(price / 1000).toStringAsFixed(0)}.000đ';

  CartItem copyWith({
    String? id,
    String? name,
    int? price,
    int? quantity,
    String? note,
    String? restaurantId,
    String? restaurantName,
  }) {
    return CartItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      note: note ?? this.note,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
    );
  }

  @override
  List<Object?> get props => [id, name, price, quantity, note, restaurantId, restaurantName];
}