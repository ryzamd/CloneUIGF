import 'package:flutter/material.dart';
import '../constants/color_constant.dart';
import '../services/responsive_service.dart';

class BaseScaffold extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final bool showAppBar;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final bool resizeToAvoidBottomInset;
  final bool extendBodyBehindAppBar;
  final bool enableResponsive;

  const BaseScaffold({
    super.key,
    this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.showAppBar = true,
    this.showBackButton = true,
    this.onBackPressed,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.drawer,
    this.resizeToAvoidBottomInset = true,
    this.extendBodyBehindAppBar = false,
    this.enableResponsive = true,
  });

  @override
  Widget build(BuildContext context) {
    if (enableResponsive) {
      ResponsiveService.init(context);
    }

    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.backgroundGrey,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: showAppBar ? _buildAppBar(context) : null,
      body: enableResponsive ? _buildResponsiveBody() : body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
    );
  }

  Widget _buildResponsiveBody() {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          ResponsiveService.init(context);
          
          if (ResponsiveService.isTablet) {
            // Tablet layout với padding lớn hơn
            return Container(
              constraints: BoxConstraints(
                maxWidth: ResponsiveService.responsive(
                  mobile: double.infinity,
                  tablet: ResponsiveService.screenWidth * 0.85,
                  desktop: 1200,
                ),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: ResponsiveService.responsive(
                  mobile: 0,
                  tablet: ResponsiveService.spacing32,
                  desktop: ResponsiveService.spacing32 * 2,
                ),
              ),
              child: body,
            );
          }
          
          return body;
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    
    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                fontSize: ResponsiveService.fontSizeLarge,
                fontWeight: FontWeight.w600,
              ),
            ) : null,
      automaticallyImplyLeading: false,
      leading: showBackButton && canPop
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: ResponsiveService.iconSizeMedium,
              ),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
      elevation: 0,
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: AppColors.textOnPrimary,
      toolbarHeight: ResponsiveService.appBarHeight,
      centerTitle: ResponsiveService.isMobile,
    );
  }
}

// Extension để dễ sử dụng ResponsiveService trong widgets
extension ResponsiveContext on BuildContext {
  ResponsiveService get responsive {
    ResponsiveService.init(this);
    return ResponsiveService();
  }
  
  bool get isMobile => ResponsiveService.isMobile;
  bool get isTablet => ResponsiveService.isTablet;
  bool get isSmallScreen => ResponsiveService.isSmallScreen;
  bool get isLargeScreen => ResponsiveService.isLargeScreen;
  
  double widthPercent(double percent) => ResponsiveService.widthPercent(percent);
  double heightPercent(double percent) => ResponsiveService.heightPercent(percent);
}