import 'package:flutter/material.dart';
import '../constants/key_constant.dart';

class NavigationService {
  static NavigatorState get navigator => AppKeys.navigatorKey.currentState!;

  // Core Navigation Methods
  static Future<void> toWelcome() async {
    await navigator.pushNamedAndRemoveUntil(
      AppRoutes.welcome,
      (route) => false,
    );
  }

  static Future<void> toLogin() async {
    await navigator.pushNamed(AppRoutes.login);
  }

  static Future<void> toRegister() async {
    await navigator.pushNamed(AppRoutes.register);
  }

  static Future<void> toDashboard() async {
    await navigator.pushNamedAndRemoveUntil(
      AppRoutes.dashboard,
      (route) => false,
    );
  }

  static Future<void> toProfile() async {
    await navigator.pushNamed(AppRoutes.profile);
  }

  static Future<void> toRestaurants() async {
    await navigator.pushNamed(AppRoutes.restaurants);
  }

  static Future<void> toRestaurantDetail(
    String restaurantId, {
    String? branchId,
  }) async {
    await navigator.pushNamed(
      AppRoutes.restaurantDetail,
      arguments: RestaurantDetailArguments(
        restaurantId: restaurantId,
        branchId: branchId,
      ),
    );
  }

  // Generic Navigation Methods
  static Future<T?> pushNamed<T>(
    String routeName, {
    Object? arguments,
  }) async {
    return await navigator.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> pushReplacementNamed<T, TO>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) async {
    return await navigator.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T>(
    String newRouteName,
    bool Function(Route<dynamic>) predicate, {
    Object? arguments,
  }) async {
    return await navigator.pushNamedAndRemoveUntil<T>(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  static void goBack<T>([T? result]) {
    if (navigator.canPop()) {
      navigator.pop<T>(result);
    }
  }

  static void goBackUntil(String routeName) {
    navigator.popUntil(ModalRoute.withName(routeName));
  }

  static void goBackWithResult<T>(T result) {
    navigator.pop<T>(result);
  }

  // Utility Methods
  static bool canPop() {
    return navigator.canPop();
  }

  static String? getCurrentRouteName() {
    String? currentRouteName;
    navigator.popUntil((route) {
      currentRouteName = route.settings.name;
      return true;
    });
    return currentRouteName;
  }

  // Dialog Navigation
  static Future<T?> showCustomDialog<T>({
    required Widget dialog,
    bool barrierDismissible = true,
    Color? barrierColor,
  }) {
    return showDialog<T>(
      context: navigator.context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      builder: (context) => dialog,
    );
  }

  // Bottom Sheet Navigation
  static Future<T?> showCustomBottomSheet<T>({
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
  }) {
    return showModalBottomSheet<T>(
      context: navigator.context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => child,
    );
  }
}

// Route Constants
class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
  static const String profile = '/profile';
  static const String restaurants = '/restaurants';
  static const String restaurantDetail = '/restaurant-detail';

  AppRoutes._();
}

// Route Arguments
abstract class RouteArguments {}

class RestaurantDetailArguments extends RouteArguments {
  final String restaurantId;
  final String? branchId;

  RestaurantDetailArguments({
    required this.restaurantId,
    this.branchId,
  });
}

class BranchSelectionArguments extends RouteArguments {
  final String restaurantId;
  final List<String> branchIds;

  BranchSelectionArguments({
    required this.restaurantId,
    required this.branchIds,
  });
}