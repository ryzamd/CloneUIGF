import 'package:cloneuigrabfood/features/cart/cubit/cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../view_model/payment_view_model.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentInitial()) {
    on<LoadPayment>(_onLoadPayment);
    on<AddItemToCart>(_onAddItemToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<ToggleEnvironmental>(_onToggleEnvironmental);
    on<SelectDeliveryOption>(_onSelectDeliveryOption);
    on<SelectPaymentMethod>(_onSelectPaymentMethod);
    on<PlaceOrder>(_onPlaceOrder);
  }

  Future<void> _onLoadPayment(LoadPayment event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());
    
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      final viewModel = PaymentViewModel.fromCartItems(event.cartItems);
      emit(PaymentLoaded(viewModel));
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }

  void _onAddItemToCart(AddItemToCart event, Emitter<PaymentState> emit) {
    if (state is PaymentLoaded) {
      final currentState = state as PaymentLoaded;
      final updatedViewModel = currentState.viewModel.addItem(event.item);
      emit(PaymentLoaded(updatedViewModel));
    }
  }

  void _onRemoveItemFromCart(RemoveItemFromCart event, Emitter<PaymentState> emit) {
    if (state is PaymentLoaded) {
      final currentState = state as PaymentLoaded;
      final updatedViewModel = currentState.viewModel.removeItem(event.item);
      emit(PaymentLoaded(updatedViewModel));
    }
  }

  void _onToggleEnvironmental(ToggleEnvironmental event, Emitter<PaymentState> emit) {
    if (state is PaymentLoaded) {
      final currentState = state as PaymentLoaded;
      final updatedViewModel = currentState.viewModel.toggleEnvironmental(event.isEnabled);
      emit(PaymentLoaded(updatedViewModel));
    }
  }

  void _onSelectDeliveryOption(SelectDeliveryOption event, Emitter<PaymentState> emit) {
    if (state is PaymentLoaded) {
      final currentState = state as PaymentLoaded;
      final updatedViewModel = currentState.viewModel.selectDeliveryOption(event.option);
      emit(PaymentLoaded(updatedViewModel));
    }
  }

  void _onSelectPaymentMethod(SelectPaymentMethod event, Emitter<PaymentState> emit) {
    if (state is PaymentLoaded) {
      final currentState = state as PaymentLoaded;
      final updatedViewModel = currentState.viewModel.selectPaymentMethod(event.method);
      emit(PaymentLoaded(updatedViewModel));
    }
  }

  Future<void> _onPlaceOrder(PlaceOrder event, Emitter<PaymentState> emit) async {
    if (state is PaymentLoaded) {
      emit(PaymentLoading());
      
      try {
        await Future.delayed(const Duration(seconds: 2)); // Simulate API call
        emit(PaymentSuccess());
      } catch (e) {
        emit(PaymentFailure('Đặt hàng thất bại: ${e.toString()}'));
      }
    }
  }
}
