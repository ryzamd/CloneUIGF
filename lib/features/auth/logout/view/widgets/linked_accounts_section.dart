import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/core.dart';
import '../../bloc/logout_bloc.dart';

class LinkedAccountsSection extends StatelessWidget {
  const LinkedAccountsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          color: AppColors.white,
          margin: EdgeInsets.only(top: ResponsiveService.spacing8),
          padding: EdgeInsets.all(ResponsiveService.spacing16),
          child: BlocBuilder<LogoutBloc, LogoutState>(
            builder: (context, state) {
              final linkedAccounts = state is LogoutLoaded
                  ? state.viewModel.linkedAccounts
                  : <String, bool>{'google': true, 'facebook': false};

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResponsiveText.title(
                    text: 'Đã liên kết tài khoản',
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: ResponsiveService.spacing16),
                  _buildAccountLink(
                    context: context,
                    icon: Icons.g_mobiledata,
                    iconColor: Colors.red,
                    title: 'Google',
                    platform: 'google',
                    isLinked: linkedAccounts['google'] ?? false,
                  ),
                  SizedBox(height: ResponsiveService.spacing16),
                  _buildAccountLink(
                    context: context,
                    icon: Icons.facebook,
                    iconColor: Colors.blue,
                    title: 'Facebook',
                    platform: 'facebook',
                    isLinked: linkedAccounts['facebook'] ?? false,
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildAccountLink({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String platform,
    required bool isLinked,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
        ),
        SizedBox(width: ResponsiveService.spacing16),
        Expanded(
          child: ResponsiveText.body(
            text: title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Transform.scale(
          scale: 0.8,
          child: Switch(
            value: isLinked,
            onChanged: (value) {
              context.read<LogoutBloc>().add(
                ToggleLinkedAccount(platform: platform, isLinked: value),
              );
            },
            activeColor: AppColors.primaryGreen,
            activeTrackColor: AppColors.lightGreen,
            inactiveThumbColor: AppColors.mediumGrey,
            inactiveTrackColor: AppColors.lightGrey,
          ),
        ),
      ],
    );
  }
}