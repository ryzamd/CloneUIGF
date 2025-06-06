// lib/features/cart/cubit/cart_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/food_item.dart';
import '../../../domain/entities/restaurant.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addItem({
    required FoodItem foodItem,
    required Restaurant restaurant,
    String note = '',
  }) {
    final cartItem = CartItem(
      id: foodItem.id,
      name: foodItem.name,
      price: foodItem.price,
      quantity: 1,
      note: note,
      restaurantId: restaurant.id,
      restaurantName: restaurant.name,
    );

    final existingIndex = state.items.indexWhere((item) => item.id == cartItem.id);
    List<CartItem> updatedItems;

    if (existingIndex >= 0) {
      updatedItems = List.from(state.items);
      updatedItems[existingIndex] = updatedItems[existingIndex].copyWith(
        quantity: updatedItems[existingIndex].quantity + 1,
      );
    } else {
      updatedItems = [...state.items, cartItem];
    }

    emit(state.copyWith(items: updatedItems));
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeItem(itemId);
      return;
    }

    final updatedItems = state.items.map((item) {
      if (item.id == itemId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    emit(state.copyWith(items: updatedItems));
  }

  void incrementItem(String itemId) {
    final item = state.items.firstWhere((item) => item.id == itemId);
    updateQuantity(itemId, item.quantity + 1);
  }

  void decrementItem(String itemId) {
    final item = state.items.firstWhere((item) => item.id == itemId);
    updateQuantity(itemId, item.quantity - 1);
  }

  void removeItem(String itemId) {
    final updatedItems = state.items.where((item) => item.id != itemId).toList();
    emit(state.copyWith(items: updatedItems));
  }

  void clearCart() {
    emit(const CartState());
  }

  void updateItemNote(String itemId, String note) {
    final updatedItems = state.items.map((item) {
      if (item.id == itemId) {
        return item.copyWith(note: note);
      }
      return item;
    }).toList();

    emit(state.copyWith(items: updatedItems));
  }
}