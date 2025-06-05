import 'package:cloneuigrabfood/features/auth/login/view/login_screen.dart';
import 'package:flutter/material.dart';
import '../../features/welcome/view/welcome_screen.dart';
import 'navigation_service.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.welcome:
        return _buildRoute(const WelcomeScreen(), settings);
        
      case AppRoutes.login:
        return _buildRoute(const LoginScreen(), settings);
        
      case AppRoutes.register:
        return _buildRoute(const RegisterScreen(), settings);
        
      case AppRoutes.dashboard:
        return _buildRoute(const DashboardScreen(), settings);
        
      case AppRoutes.profile:
        return _buildRoute(const ProfileScreen(), settings);
        
      case AppRoutes.restaurants:
        return _buildRoute(const RestaurantsScreen(), settings);
        
      case AppRoutes.restaurantDetail:
        final args = settings.arguments as RestaurantDetailArguments?;
        if (args == null) {
          return _buildErrorRoute('RestaurantDetailArguments required');
        }
        return _buildRoute(
          RestaurantDetailScreen(
            restaurantId: args.restaurantId,
            branchId: args.branchId,
          ),
          settings,
        );
        
      default:
        return _buildErrorRoute('Route not found: ${settings.name}');
    }
  }
  
  static PageRoute _buildRoute(Widget page, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Custom slide transition
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        
        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );
        
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
  
  static Route<dynamic> _buildErrorRoute(String message) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(message, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => NavigationService.toWelcome(),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class RestaurantsScreen extends StatelessWidget {
  const RestaurantsScreen({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
}

class RestaurantDetailScreen extends StatelessWidget {
  final String restaurantId;
  final String? branchId;
  
  const RestaurantDetailScreen({
    super.key,
    required this.restaurantId,
    this.branchId,
  });
  
  @override
  Widget build(BuildContext context) => const Placeholder();
}