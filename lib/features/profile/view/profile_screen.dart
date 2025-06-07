import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/core.dart';
import '../../../di/dependency_injection.dart';
import '../bloc/profile_bloc.dart';
import 'widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ProfileBloc>()..add(const LoadProfile()),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return BaseScaffold(
          showAppBar: false,
          backgroundColor: AppColors.backgroundGrey,
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const LoadingWidget();
              }

              if (state is ProfileError) {
                return AppErrorWidget(
                  message: state.message,
                  onRetry: () => context.read<ProfileBloc>().add(const LoadProfile()),
                );
              }

              return const CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: ProfileHeader()),
                  SliverToBoxAdapter(child: GrabUnlimitedSection()),
                  SliverToBoxAdapter(child: ProfileTabsSection()),
                  SliverToBoxAdapter(child: PaymentSection()),
                  SliverToBoxAdapter(child: AccountServicesSection()),
                  SliverToBoxAdapter(child: OffersSection()),
                  SliverToBoxAdapter(child: GeneralSection()),
                  SliverToBoxAdapter(child: LogoutSection()),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 100),
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