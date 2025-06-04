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

// Temporary Welcome Screen để test core components
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showAppBar: false,
      backgroundColor: AppColors.backgroundGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo/Icon placeholder
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.restaurant,
                  size: 60,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 32),
              
              // Welcome text
              Text(
                AppStrings.welcome,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                AppStrings.grabFood,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                AppStrings.welcomeSubtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              // Get Started Button
              PrimaryButton(
                text: AppStrings.getStarted,
                size: ButtonSize.large,
                onPressed: () => _showTestDialog(context),
              ),
              const SizedBox(height: 16),
              
              // Secondary buttons để test
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      text: 'Test Loading',
                      type: ButtonType.secondary,
                      size: ButtonSize.medium,
                      onPressed: () => _showLoadingTest(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Test Error',
                      type: ButtonType.outline,
                      size: ButtonSize.medium,
                      onPressed: () => _showErrorTest(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTestDialog(BuildContext context) {
    NotificationDialog.showSuccess(
      context: context,
      title: 'Core Setup Complete!',
      message: 'Core folder đã được setup thành công với tất cả components cần thiết.',
      buttonText: 'Tuyệt vời',
      onPressed: () {
        AppConfig.log('Welcome dialog shown', tag: 'UI');
      },
    );
  }

  void _showLoadingTest(BuildContext context) {
    DialogService.showLoading(message: 'Đang test loading...');
    
    // Simulate loading
    Future.delayed(const Duration(seconds: 2), () {
      DialogService.hideLoading();
      DialogService.showSuccessSnackBar('Loading test hoàn thành!');
    });
  }

  void _showErrorTest(BuildContext context) {
    DialogService.showError(
      message: 'Đây là test error dialog từ Core components',
      title: 'Test Error',
      onPressed: () {
        DialogService.showInfoSnackBar('Error dialog đã được đóng');
      },
    );
  }
}