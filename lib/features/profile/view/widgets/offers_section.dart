import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

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
                text: 'Ưu đãi và tiết kiệm',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: ResponsiveService.spacing16),
              _OfferItem(
                title: 'GrabRewards',
                value: '0 Điểm',
                icon: Icons.card_giftcard,
                onTap: () {},
              ),
              _OfferItem(
                title: 'Gói Hội Viên',
                value: 'Mới',
                valueColor: AppColors.error,
                icon: Icons.local_offer,
                onTap: () {},
              ),
              _OfferItem(
                title: 'Thử thách',
                icon: Icons.emoji_events,
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OfferItem extends StatelessWidget {
  final String title;
  final String? value;
  final Color? valueColor;
  final IconData icon;
  final VoidCallback onTap;

  const _OfferItem({
    required this.title,
    this.value,
    this.valueColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ResponsiveService.spacing12),
        child: Row(
          children: [
            ResponsiveText.body(
              text: title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            if (value != null) ...[
              ResponsiveText.body(
                text: value!,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: valueColor ?? AppColors.textSecondary,
                ),
              ),
              SizedBox(width: ResponsiveService.spacing8),
            ],
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.mediumGrey,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}