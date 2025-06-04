import 'package:flutter/material.dart';
import '../constants/key_constant.dart';

class AppTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final Key? fieldKey;

  const AppTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.fieldKey,
  });

  // Factory constructors với predefined keys
  factory AppTextField.email({
    Key? key,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return AppTextField(
      key: key,
      fieldKey: AppKeys.emailFieldKey,
      labelText: 'Email',
      hintText: 'Nhập email của bạn',
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      prefixIcon: const Icon(Icons.email_outlined),
    );
  }

  factory AppTextField.password({
    Key? key,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    bool obscureText = true,
    Widget? suffixIcon,
  }) {
    return AppTextField(
      key: key,
      fieldKey: AppKeys.passwordFieldKey,
      labelText: 'Mật khẩu',
      hintText: 'Nhập mật khẩu',
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      prefixIcon: const Icon(Icons.lock_outlined),
      suffixIcon: suffixIcon,
    );
  }

  factory AppTextField.confirmPassword({
    Key? key,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    bool obscureText = true,
    Widget? suffixIcon,
  }) {
    return AppTextField(
      key: key,
      fieldKey: AppKeys.confirmPasswordFieldKey,
      labelText: 'Xác nhận mật khẩu',
      hintText: 'Nhập lại mật khẩu',
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      prefixIcon: const Icon(Icons.lock_outlined),
      suffixIcon: suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: fieldKey,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      readOnly: readOnly,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}