import 'package:cloneuigrabfood/features/auth/login/view/widgets/back_button_widget.dart';
import 'package:cloneuigrabfood/features/auth/login/view/widgets/divider_section.dart';
import 'package:cloneuigrabfood/features/auth/login/view/widgets/face_id_section.dart';
import 'package:cloneuigrabfood/features/auth/login/view/widgets/login_options_section.dart';
import 'package:cloneuigrabfood/features/auth/login/view/widgets/logo_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../../di/dependency_injection.dart';
import '../bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<LoginBloc>(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final double spacing = screenHeight * 0.03;

    return BaseScaffold(
      showAppBar: false,
      backgroundColor: AppColors.primaryGreen,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          switch (state) {
            case LoginSuccess():
              NavigationService.toDashboard();
              DialogService.hideLoading();
               break;
               
            case LoginLoading():
              DialogService.showLoading();
              break;

            
            case LoginFailure():
              DialogService.showError(message: state.message, title: 'Đăng nhập thất bại');
              break;
            

          }
          // if (state is LoginSuccess) {
          //   NavigationService.toDashboard();
          // } else if (state is LoginFailure) {
          //   DialogService.showError(
          //     message: state.message,
          //     title: 'Đăng nhập thất bại',
          //   );
          // } if (state is LoginLoading){
          //   DialogService.showLoading();
          // }
        },
        builder: (context, state) {
          return Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      SizedBox(height: spacing),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Transform.translate(
                          offset: const Offset(-18, 0),
                          child: const BackButtonWidget()
                        )
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LogoSection(),
                            SizedBox(height: spacing),
                            FaceIdSection(),
                            SizedBox(height: spacing),
                            DividerSection(),
                            SizedBox(height: spacing),
                            LoginOptionsSection(),
                          ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
