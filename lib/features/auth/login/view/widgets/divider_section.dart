import 'package:flutter/material.dart';
import '../../../../../core/core.dart';

class DividerSection extends StatelessWidget {
  const DividerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: AppColors.white,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'hoặc',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
        const Expanded(
          child: Divider(
            color: AppColors.white,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}