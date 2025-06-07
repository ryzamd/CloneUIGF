import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../../di/dependency_injection.dart';
import '../bloc/logout_bloc.dart';
import 'widgets/widgets.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<LogoutBloc>()..add(const LoadLogoutProfile()),
      child: const LogoutView(),
    );
  }
}

class LogoutView extends StatelessWidget {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (context, responsive) {
        return BaseScaffold(
          showAppBar: false,
          backgroundColor: AppColors.backgroundGrey,
          body: BlocBuilder<LogoutBloc, LogoutState>(
            builder: (context, state) {
              if (state is LogoutLoading) {
                return const LoadingWidget();
              }

              if (state is LogoutError) {
                return AppErrorWidget(
                  message: state.message,
                  onRetry: () => context.read<LogoutBloc>().add(const LoadLogoutProfile()),
                );
              }

              return const CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: LogoutHeader()),
                  SliverToBoxAdapter(child: ProfileAvatarSection()),
                  SliverToBoxAdapter(child: PersonalInfoForm()),
                  SliverToBoxAdapter(child: SupportSection()),
                  SliverToBoxAdapter(child: BusinessAccountSection()),
                  SliverToBoxAdapter(child: LinkedAccountsSection()),
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