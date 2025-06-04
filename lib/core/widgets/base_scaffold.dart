import 'package:flutter/material.dart';
import '../constants/color_constant.dart';

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
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.backgroundGrey,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: showAppBar ? _buildAppBar(context) : null,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      drawer: drawer,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    // Cache common properties to avoid recreating
    final canPop = Navigator.of(context).canPop();
    
    return AppBar(
      title: title != null ? Text(title!) : null,
      automaticallyImplyLeading: false,
      leading: showBackButton && canPop
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
      elevation: 0,
      backgroundColor: AppColors.primaryGreen,
      foregroundColor: AppColors.textOnPrimary,
    );
  }
}