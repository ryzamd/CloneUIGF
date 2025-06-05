import 'package:flutter/material.dart';
import '../../../../../core/core.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Grab',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
            color: AppColors.white,
            fontSize: 64,
            fontWeight: FontWeight.bold,
            letterSpacing: -2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Siêu ứng dụng đáp ứng mọi nhu cầu\nhàng ngày',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.white,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}