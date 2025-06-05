import 'package:cloneuigrabfood/features/auth/login/view/widgets/login_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/core.dart';
import '../../bloc/login_bloc.dart';

class CredentialLoginForm extends StatefulWidget {
  final VoidCallback onBackToOptions;

  const CredentialLoginForm({
    super.key,
    required this.onBackToOptions,
  });

  @override
  State<CredentialLoginForm> createState() => _CredentialLoginFormState();
}

class _CredentialLoginFormState extends State<CredentialLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  
  bool _obscurePassword = true;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _clearErrors() {
    if (_emailError != null || _passwordError != null) {
      setState(() {
        _emailError = null;
        _passwordError = null;
      });
    }
  }

  void _handleLogin() {
    _clearErrors();
    
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(
        LoginWithCredentials(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          setState(() {
            if (state.message.contains('tài khoản') || 
                state.message.contains('email')) {
              _emailError = state.message;
            } else if (state.message.contains('mật khẩu')) {
              _passwordError = state.message;
            } else {
              _emailError = 'Email hoặc mật khẩu không đúng';
              _passwordError = 'Email hoặc mật khẩu không đúng';
            }
          });
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Đăng nhập',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 48),
            
            LoginTextField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              label: 'Email',
              hintText: 'Nhập email của bạn',
              keyboardType: TextInputType.emailAddress,
              errorText: _emailError,
              onChanged: (_) => _clearErrors(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập email';
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Email không đúng định dạng';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            
            LoginTextField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              label: 'Mật khẩu',
              hintText: 'Nhập mật khẩu',
              obscureText: _obscurePassword,
              errorText: _passwordError,
              onChanged: (_) => _clearErrors(),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.white.withValues(alpha: 0.7),
                ),
                onPressed: _togglePasswordVisibility,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                if (value.length < 6) {
                  return 'Mật khẩu phải có ít nhất 6 ký tự';
                }
                return null;
              },
              onFieldSubmitted: (_) => _handleLogin(),
            ),
            const SizedBox(height: 24),
            
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                },
                child: Text(
                  'Quên mật khẩu?',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: state is LoginLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.white,
                      foregroundColor: AppColors.primaryGreen,
                      disabledBackgroundColor: AppColors.white.withValues(alpha: 0.6),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: state is LoginLoading
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primaryGreen,
                              ),
                            ),
                          )
                        : const Text(
                            'Đăng nhập',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Chưa có tài khoản? ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () => NavigationService.toRegister(),
                  child: Text(
                    'Đăng ký ngay',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}