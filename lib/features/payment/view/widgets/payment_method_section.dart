import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../../view_model/payment_view_model.dart';

class PaymentMethodSection extends StatelessWidget {
  final PaymentMethod selectedMethod;
  final List<PaymentMethod> methods;
  final Function(PaymentMethod) onMethodSelected;

  const PaymentMethodSection({
    super.key,
    required this.selectedMethod,
    required this.methods,
    required this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      margin: EdgeInsets.only(top: ResponsiveService.spacing8),
      padding: EdgeInsets.all(ResponsiveService.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ResponsiveText.title(
                text: 'Thông tin thanh toán',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {},
                child: ResponsiveText.body(
                  text: 'Xem tất cả',
                  style: const TextStyle(color: AppColors.primaryGreen),
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveService.spacing16),
          ...methods.map((method) => _PaymentMethodCard(
            method: method,
            isSelected: method.id == selectedMethod.id,
            onTap: () => onMethodSelected(method),
          )),
        ],
      ),
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodCard({
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: ResponsiveService.spacing12),
        padding: EdgeInsets.all(ResponsiveService.spacing16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusMedium),
        ),
        child: Row(
          children: [
            Icon(
              method.icon,
              color: method.isActive ? AppColors.primaryGreen : AppColors.mediumGrey,
              size: ResponsiveService.iconSizeMedium,
            ),
            SizedBox(width: ResponsiveService.spacing16),
            Expanded(
              child: ResponsiveText.body(
                text: method.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            if (method.isActive)
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: AppColors.primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.white,
                  size: 14,
                ),
              )
            else
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveService.spacing8,
                  vertical: ResponsiveService.spacing4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ResponsiveText.caption(
                  text: method.subtitle,
                  style: const TextStyle(color: AppColors.textHint),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

