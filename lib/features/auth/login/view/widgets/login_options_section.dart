import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/login_bloc.dart';
import 'login_option_button.dart';

class LoginOptionsSection extends StatelessWidget {
  const LoginOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LoginOptionButton(
          icon: Icons.facebook,
          iconColor: Colors.blue,
          text: 'Tiếp tục với Facebook',
          onPressed: () {
            context.read<LoginBloc>().add(
              const LoginWithSocial(LoginMethod.facebook),
            );
          },
        ),
        const SizedBox(height: 16),
        LoginOptionButton(
          icon: Icons.g_mobiledata,
          iconColor: Colors.red,
          text: 'Tiếp tục với Google',
          onPressed: () {
            context.read<LoginBloc>().add(
              const LoginWithSocial(LoginMethod.google),
            );
          },
        ),
        const SizedBox(height: 16),
        LoginOptionButton(
          icon: Icons.apple,
          iconColor: Colors.black,
          text: 'Tiếp tục với Apple',
          onPressed: () {
            context.read<LoginBloc>().add(
              const LoginWithSocial(LoginMethod.apple),
            );
          },
        ),
        const SizedBox(height: 16),
        LoginOptionButton(
          icon: Icons.phone,
          iconColor: Colors.black,
          text: 'Tiếp tục với số điện thoại',
          onPressed: () {
            context.read<LoginBloc>().add(
              const LoginWithPhone(),
            );
          },
        ),
      ],
    );
  }
}