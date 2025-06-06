import 'package:cloneuigrabfood/features/payment/view/widgets/cart_items_section.dart';
import 'package:cloneuigrabfood/features/payment/view/widgets/payment_total_section.dart';
import 'package:cloneuigrabfood/features/payment/view_model/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/core.dart';
import '../../cart/cubit/cart_cubit.dart';
import '../bloc/payment_bloc.dart';
import 'widgets/widgets.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  void initState() {
    super.initState();
    final cartItems = context.read<CartCubit>().state.items;
    context.read<PaymentBloc>().add(LoadPayment(List.from(cartItems)));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return BaseScaffold(
          showAppBar: false,
          backgroundColor: AppColors.backgroundGrey,
          body: BlocConsumer<PaymentBloc, PaymentState>(
            listener: (context, state) {
              if (state is PaymentSuccess) {
                context.read<CartCubit>().clearCartAfterSuccess();
                _showSuccessAndNavigate(context);
              } else if (state is PaymentFailure) {
                DialogService.showError(
                  title: 'Đặt hàng thất bại',
                  message: state.message,
                );
              }
            },
            builder: (context, state) {
              return BlocBuilder<CartCubit, CartState>(
                builder: (context, cartState) {
                  if (cartState.isEmpty && !cartState.isOrderSuccessful) {
                    return const Center(
                      child: AppErrorWidget(
                        message: 'Giỏ hàng trống',
                        showRetryButton: false,
                      ),
                    );
                  }

                  if (cartState.isOrderSuccessful) {
                    return const LoadingWidget(message: 'Đang hoàn tất đơn hàng...');
                  }

                  if (state is PaymentLoading) {
                    return const LoadingWidget(message: 'Đang xử lý đơn hàng...');
                  }

                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: PaymentHeader(
                          restaurantName: cartState.restaurantName ?? 'Nhà hàng',
                          distance: '6.3 km',
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: CartItemsSection(cartState: cartState),
                      ),

                      SliverToBoxAdapter(
                        child: BlocBuilder<PaymentBloc, PaymentState>(
                          builder: (context, paymentState) {
                            final isEnabled = paymentState is PaymentLoaded
                                ? paymentState.viewModel.isEnvironmentalEnabled
                                : false;
                            return EnvironmentalSection(
                              isEnabled: isEnabled,
                              onToggle: (value) => context.read<PaymentBloc>().add(ToggleEnvironmental(value)),
                            );
                          },
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: LocationSection(
                          address: 'Binh Loc Commune, Long Khanh City, Dong Nai',
                          onAddressChange: () {},
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: BlocBuilder<PaymentBloc, PaymentState>(
                          builder: (context, paymentState) {
                            if (paymentState is PaymentLoaded) {
                              return DeliveryOptionsSection(
                                selectedOption: paymentState.viewModel.selectedDeliveryOption,
                                options: paymentState.viewModel.deliveryOptions,
                                onOptionSelected: (option) => context.read<PaymentBloc>().add(SelectDeliveryOption(option)),
                              );
                            }
                            return DeliveryOptionsSection(
                              selectedOption: DeliveryOption.fast(),
                              options: DeliveryOption.getAll(),
                              onOptionSelected: (option) => context.read<PaymentBloc>().add(SelectDeliveryOption(option)),
                            );
                          },
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: BlocBuilder<PaymentBloc, PaymentState>(
                          builder: (context, paymentState) {
                            if (paymentState is PaymentLoaded) {
                              return PaymentMethodSection(
                                selectedMethod: paymentState.viewModel.selectedPaymentMethod,
                                methods: paymentState.viewModel.paymentMethods,
                                onMethodSelected: (method) => context.read<PaymentBloc>().add(SelectPaymentMethod(method)),
                              );
                            }
                            return PaymentMethodSection(
                              selectedMethod: PaymentMethod.cash(),
                              methods: PaymentMethod.getAll(),
                              onMethodSelected: (method) => context.read<PaymentBloc>().add(SelectPaymentMethod(method)),
                            );
                          },
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: PromotionsSection(
                          appliedPromo: null,
                          onApplyPromo: () {},
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: PaymentTotalSection(cartState: cartState),
                      ),

                      SliverToBoxAdapter(
                        child: SizedBox(height: ResponsiveService.spacing24),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void _showSuccessAndNavigate(BuildContext context) async {
    await DialogService.showSuccess(
      title: 'Đặt hàng thành công',
      message: 'Đơn hàng của bạn đã được xác nhận và đang được chuẩn bị',
    );
    
    if (context.mounted) {
      Navigator.of(context).pop(PaymentResult.success);
    }
  }
}