import 'package:flutter/material.dart';
import '../../../../../core/core.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () => NavigationService.goBack(),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.white,
          size: 24,
        ),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}