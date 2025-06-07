import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          color: AppColors.white,
          margin: EdgeInsets.only(top: ResponsiveService.spacing8),
          padding: EdgeInsets.all(ResponsiveService.spacing16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ResponsiveText.title(
                text: 'Thanh toán dễ dàng với Grab',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: ResponsiveService.spacing4),
              ResponsiveText.caption(
                text: 'Thêm phương thức thanh toán ngay',
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              SizedBox(height: ResponsiveService.spacing16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _PaymentIcon(Icons.credit_card, AppColors.info),
                  SizedBox(width: ResponsiveService.spacing8),
                  _PaymentIcon(Icons.account_balance, AppColors.primaryGreen),
                  SizedBox(width: ResponsiveService.spacing8),
                  _PaymentIcon(Icons.credit_card, AppColors.info),
                  SizedBox(width: ResponsiveService.spacing8),
                  _PaymentIcon(Icons.account_balance, AppColors.primaryGreen),
                  SizedBox(width: ResponsiveService.spacing8),
                  _PaymentIcon(Icons.credit_card, AppColors.orange),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PaymentIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _PaymentIcon(this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        icon,
        color: AppColors.white,
        size: 18,
      ),
    );
  }
}