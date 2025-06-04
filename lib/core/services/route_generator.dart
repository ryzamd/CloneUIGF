import 'package:flutter/material.dart';
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

// Placeholder screens - sẽ replace sau
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo/Icon
              Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  color: Color(0xFF00AA13),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.restaurant,
                  size: 60,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              
              // Welcome text
              const Text(
                'Chào mừng đến với',
                style: TextStyle(fontSize: 20, color: Color(0xFF666666)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'GrabFood',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00AA13),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Đặt món ngon, giao nhanh tận nơi',
                style: TextStyle(fontSize: 16, color: Color(0xFF666666)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              // Get Started Button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Core setup complete! 🎉'),
                        backgroundColor: Color(0xFF00AA13),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00AA13),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Bắt đầu',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) => const Placeholder();
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