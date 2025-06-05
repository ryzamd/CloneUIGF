import 'package:flutter/material.dart';
import '../../../../../core/core.dart';

class FaceIdSection extends StatelessWidget {
  const FaceIdSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Đăng nhập với Face ID',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.white,
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.white,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.face_unlock_outlined,
            color: AppColors.white,
            size: 48,
          ),
        ),
      ],
    );
  }
}