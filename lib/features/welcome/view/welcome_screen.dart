import 'package:flutter/material.dart';
import '../../../../core/constants/color_constant.dart';
import '../../../../core/widgets/base_scaffold.dart';
import 'widgets/welcome_banner.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/category_section.dart';
import 'widgets/food_section.dart';
import 'widgets/shopping_section.dart';
import 'widgets/bottom_buttons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showAppBar: false,
      backgroundColor: AppColors.white,
      body: const SafeArea(
        child: Column(
          children: [
            _StatusBar(),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    WelcomeBanner(),
                    
                    SearchBarWidget(),
                    
                    CategorySection(),
                    
                    FoodSection(),
                    
                    ShoppingSection(),
                    
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomButtons(),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: AppColors.primaryGreen,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Text(
            '08:18',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Icon(
            Icons.location_on,
            color: AppColors.white,
            size: 16,
          ),
          const Spacer(),
          const Icon(
            Icons.signal_cellular_4_bar,
            color: AppColors.white,
            size: 16,
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.wifi,
            color: AppColors.white,
            size: 16,
          ),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              '79',
              style: TextStyle(
                color: AppColors.primaryGreen,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}