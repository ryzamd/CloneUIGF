import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../bloc/profile_bloc.dart';

class ProfileTabsSection extends StatelessWidget {
  const ProfileTabsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return Container(
          color: AppColors.white,
          margin: EdgeInsets.only(top: ResponsiveService.spacing8),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              final selectedTab = state is ProfileLoaded ? state.viewModel.selectedTab : 0;

              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _TabItem(
                          title: 'Mục chính',
                          isSelected: selectedTab == 0,
                          onTap: () => context.read<ProfileBloc>().add(const UpdateTab(0)),
                        ),
                      ),
                      Expanded(
                        child: _TabItem(
                          title: 'Hoạt động',
                          isSelected: selectedTab == 1,
                          onTap: () => context.read<ProfileBloc>().add(const UpdateTab(1)),
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

class _TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ResponsiveService.spacing16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColors.primaryGreen : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: ResponsiveText.body(
            text: title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected ? AppColors.primaryGreen : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}