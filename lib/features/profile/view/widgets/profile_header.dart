import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../bloc/profile_bloc.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          color: AppColors.white,
          padding: EdgeInsets.all(ResponsiveService.spacing16),
          child: SafeArea(
            bottom: false,
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                final userName = state is ProfileLoaded ? state.viewModel.userName : 'UKNOWN USER';

                return Row(
                  children: [
                    GestureDetector(
                      onTap: () => NavigationService.goBack(),
                      child: SizedBox(
                        width: ResponsiveService.spacing32,
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.textSecondary,
                          size: 24,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => NavigationService.toLogout(),
                      child: Container(
                        width: ResponsiveService.responsive(
                          mobile: 50.0,
                          tablet: 60.0,
                        ),
                        height: ResponsiveService.responsive(
                          mobile: 50.0,
                          tablet: 60.0,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: AppColors.white,
                          size: 28,
                        ),
                      ),
                    ),
                    SizedBox(width: ResponsiveService.spacing16),
                    Expanded(
                      child: ResponsiveText.title(
                        text: userName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveService.spacing12,
                        vertical: ResponsiveService.spacing8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ResponsiveText.body(
                        text: 'Hồ sơ',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}