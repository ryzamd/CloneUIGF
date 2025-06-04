import 'package:flutter/material.dart';
import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize app configuration
  AppConfig.initialize(Environment.development);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.instance.appName,
      theme: AppTheme.lightTheme,
      
      // Navigation setup with route generator
      navigatorKey: AppKeys.navigatorKey,
      scaffoldMessengerKey: AppKeys.scaffoldMessengerKey,
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: AppRoutes.welcome,
      
      // Handle unknown routes
      onUnknownRoute: (settings) => RouteGenerator.generateRoute(
        RouteSettings(name: '/error', arguments: settings.arguments),
      ),
      
      // Debug settings
      debugShowCheckedModeBanner: AppConfig.isDevelopment,
    );
  }
}