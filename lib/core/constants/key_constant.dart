import 'package:flutter/material.dart';

class AppKeys {
  // Navigation
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  
  // Form Keys
  static final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  
  // Page Keys
  static const Key welcomeScreenKey = Key('welcome_screen');
  static const Key dashboardScreenKey = Key('dashboard_screen');
  static const Key restaurantsScreenKey = Key('restaurants_screen');
  static const Key restaurantDetailScreenKey = Key('restaurant_detail_screen');
  static const Key profileScreenKey = Key('profile_screen');
  
  // Widget Keys for Testing
  static const Key loginButtonKey = Key('login_button');
  static const Key registerButtonKey = Key('register_button');
  static const Key logoutButtonKey = Key('logout_button');
  static const Key foodIconKey = Key('food_icon');
  static const Key profileIconKey = Key('profile_icon');
  
  // Input Field Keys
  static const Key emailFieldKey = Key('email_field');
  static const Key passwordFieldKey = Key('password_field');
  static const Key confirmPasswordFieldKey = Key('confirm_password_field');
  
  // Dialog Keys
  static const Key errorDialogKey = Key('error_dialog');
  static const Key confirmDialogKey = Key('confirm_dialog');
  static const Key notificationDialogKey = Key('notification_dialog');
  
  // List Keys
  static const Key restaurantListKey = Key('restaurant_list');
  static const Key menuListKey = Key('menu_list');
  
  AppKeys._(); // Prevent instantiation
}