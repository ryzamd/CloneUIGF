import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/core.dart';
import '../../bloc/logout_bloc.dart';

class ProfileAvatarSection extends StatelessWidget {
  const ProfileAvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          color: AppColors.white,
          padding: EdgeInsets.all(ResponsiveService.spacing24),
          child: BlocBuilder<LogoutBloc, LogoutState>(
            builder: (context, state) {
              final viewModel = state is LogoutLoaded ? state.viewModel : null;

              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: ResponsiveService.responsive(
                          mobile: 100.0,
                          tablet: 120.0,
                        ),
                        height: ResponsiveService.responsive(
                          mobile: 100.0,
                          tablet: 120.0,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.primaryGreen,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          color: AppColors.white,
                          size: 50,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            context.read<LogoutBloc>().add(
                              const UpdateAvatar('new_avatar_url'),
                            );
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: AppColors.primaryGreen,
                              shape: BoxShape.circle,
                              border: Border.fromBorderSide(
                                BorderSide(color: AppColors.white, width: 2),
                              ),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: AppColors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ResponsiveService.spacing16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.card_giftcard,
                        color: AppColors.orange,
                        size: 20,
                      ),
                      SizedBox(width: ResponsiveService.spacing8),
                      ResponsiveText.body(
                        text: '${viewModel?.rewardPoints ?? 0} Điểm',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(width: ResponsiveService.spacing4),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.mediumGrey,
                        size: 14,
                      ),
                    ],
                  ),
                  SizedBox(height: ResponsiveService.spacing12),
                  if (viewModel?.isGrabPinEnabled == true)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: AppColors.info,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: AppColors.white,
                            size: 8,
                          ),
                        ),
                        SizedBox(width: ResponsiveService.spacing8),
                        ResponsiveText.caption(
                          text: 'GrabPIN Enabled',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}