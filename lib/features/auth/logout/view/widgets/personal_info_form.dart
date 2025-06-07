import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/core.dart';
import '../../bloc/logout_bloc.dart';

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({super.key});

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          color: AppColors.white,
          margin: EdgeInsets.only(top: ResponsiveService.spacing8),
          padding: EdgeInsets.all(ResponsiveService.spacing16),
          child: BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              if (state is LogoutLoaded) {
                _nameController.text = state.viewModel.name;
                _phoneController.text = state.viewModel.phone;
                _emailController.text = state.viewModel.email;
              }
            },
            builder: (context, state) {
              final viewModel = state is LogoutLoaded ? state.viewModel : null;

              return Column(
                children: [
                  _buildTextField(
                    controller: _nameController,
                    label: 'Tên',
                    hintText: 'Nhập tên của bạn',
                    onChanged: (value) => _updatePersonalInfo(name: value),
                  ),
                  SizedBox(height: ResponsiveService.spacing16),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveService.spacing12,
                          vertical: ResponsiveService.spacing16,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.lightGrey),
                          borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusMedium),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 16,
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.star,
                                  color: AppColors.warning,
                                  size: 12,
                                ),
                              ),
                            ),
                            SizedBox(width: ResponsiveService.spacing8),
                            ResponsiveText.body(
                              text: '+84',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: ResponsiveService.spacing12),
                      Expanded(
                        child: _buildTextField(
                          controller: _phoneController,
                          hintText: 'Số điện thoại',
                          keyboardType: TextInputType.phone,
                          onChanged: (value) => _updatePersonalInfo(phone: value),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ResponsiveService.spacing16),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => _updatePersonalInfo(email: value),
                  ),
                  SizedBox(height: ResponsiveService.spacing16),
                  _buildGenderDropdown(viewModel?.gender ?? 'Vui lòng chọn giới tính'),
                  SizedBox(height: ResponsiveService.spacing16),
                  ResponsiveText.caption(
                    text: 'Chúng tôi sẽ liên hệ đến bạn qua email khi có vấn đề liên quan đến tài khoản và tin tức mới về sản phẩm.',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void _updatePersonalInfo({String? name, String? phone, String? email, String? gender}) {
    context.read<LogoutBloc>().add(UpdatePersonalInfo(
      name: name,
      phone: phone,
      email: email,
      gender: gender,
    ));
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    void Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          ResponsiveText.body(
            text: label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: ResponsiveService.spacing8),
        ],
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusMedium),
              borderSide: const BorderSide(color: AppColors.lightGrey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusMedium),
              borderSide: const BorderSide(color: AppColors.lightGrey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusMedium),
              borderSide: const BorderSide(color: AppColors.primaryGreen, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderDropdown(String selectedGender) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveService.spacing16,
        vertical: ResponsiveService.spacing4,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGrey),
        borderRadius: BorderRadius.circular(ResponsiveService.borderRadiusMedium),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedGender,
          isExpanded: true,
          hint: ResponsiveText.body(
            text: 'Vui lòng chọn giới tính',
            style: const TextStyle(color: AppColors.textHint),
          ),
          items: [
            'Vui lòng chọn giới tính',
            'Nam',
            'Nữ',
            'Khác',
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: ResponsiveText.body(
                text: value,
                style: TextStyle(
                  color: value == 'Vui lòng chọn giới tính' ? AppColors.textHint : AppColors.textPrimary,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              _updatePersonalInfo(gender: newValue);
            }
          },
        ),
      ),
    );
  }
}