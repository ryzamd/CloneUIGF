import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                text: 'Đăng ký',
                type: ButtonType.outline,
                onPressed: () {
                  NavigationService.toRegister();
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: PrimaryButton(
                text: 'Đăng nhập',
                onPressed: () {
                  NavigationService.toLogin();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}