import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../bloc/payment_bloc.dart';

class PaymentTotalSection extends StatelessWidget {
  final CartState cartState;

  const PaymentTotalSection({
    super.key,
    required this.cartState,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: EdgeInsets.only(top: ResponsiveService.spacing8),
      padding: EdgeInsets.all(ResponsiveService.spacing16),
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, paymentState) {
          final environmentalFee = paymentState is PaymentLoaded && paymentState.viewModel.isEnvironmentalEnabled ? 1000 : 0;
          final deliveryFee = paymentState is PaymentLoaded ? paymentState.viewModel.deliveryFee : 33000;
          final discount = 9600;
          final total = cartState.subtotal + deliveryFee + environmentalFee - discount;

          return Column(
            children: [
              _buildTotalRow('Tạm tính', _formatPrice(cartState.subtotal)),
              SizedBox(height: ResponsiveService.spacing8),
              _buildTotalRow('Phí giao hàng', _formatPrice(deliveryFee)),
              if (environmentalFee > 0) ...[
                SizedBox(height: ResponsiveService.spacing8),
                _buildTotalRow('Phí môi trường', _formatPrice(environmentalFee)),
              ],
              SizedBox(height: ResponsiveService.spacing8),
              _buildTotalRow('Giảm giá', '-${_formatPrice(discount)}', textColor: AppColors.primaryGreen),
              const Divider(height: 24),
              _buildTotalRow('Tổng cộng', _formatPrice(total), isTotal: true),
              SizedBox(height: ResponsiveService.spacing8),
              if (discount > 0)
                Row(
                  children: [
                    ResponsiveText.caption(
                      text: 'Bạn tiết kiệm được ${_formatPrice(discount)} 🎉!',
                      style: const TextStyle(
                        color: AppColors.primaryGreen,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    ResponsiveText.caption(
                      text: _formatPrice(total + discount),
                      style: const TextStyle(
                        color: AppColors.textHint,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
              SizedBox(height: ResponsiveService.spacing24),
              BlocBuilder<PaymentBloc, PaymentState>(
                builder: (context, state) {
                  return PrimaryButton(
                    text: 'Đặt đơn',
                    isLoading: state is PaymentLoading,
                    onPressed: state is PaymentLoading
                        ? null
                        : () => context.read<PaymentBloc>().add(const PlaceOrder()),
                    backgroundColor: AppColors.primaryGreen,
                    width: double.infinity,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, {bool isTotal = false, Color? textColor}) {
    return Row(
      children: [
        ResponsiveText.body(
          text: label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
            fontSize: isTotal ? 18 : 14,
          ),
        ),
        const Spacer(),
        ResponsiveText.body(
          text: value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: isTotal ? 18 : 14,
            color: textColor,
          ),
        ),
      ],
    );
  }

  String _formatPrice(int price) {
    return '${(price / 1000).toStringAsFixed(0)}.000đ';
  }
}

enum PaymentResult { success, cancelled }