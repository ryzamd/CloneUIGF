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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    WelcomeBanner(),
                    
                    SearchBarWidget(),
                    
                    CategorySection(),
                    
                    FoodSection(),
                    
                    ShoppingSection(),
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