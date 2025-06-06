import 'package:cloneuigrabfood/di/dependency_injection.dart';
import 'package:cloneuigrabfood/features/cart/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize app configuration
  AppConfig.initialize(Environment.development);
  
  await setupDependencies();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocProvider(
      create: (context) => CartCubit(),
      child: MaterialApp(
        title: AppConfig.instance.appName,
        theme: AppTheme.lightTheme,
        
        navigatorKey: AppKeys.navigatorKey,
        scaffoldMessengerKey: AppKeys.scaffoldMessengerKey,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: AppRoutes.welcome,
        onUnknownRoute: (settings) => RouteGenerator.generateRoute(
          RouteSettings(name: '/error', arguments: settings.arguments),
        ),
        
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}