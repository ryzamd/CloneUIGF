import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/core.dart';
import '../../../core/widgets/dashboard_bottom_navbar.dart';
import '../../../di/dependency_injection.dart';
import 'bloc/dashboard_bloc.dart';
import 'widgets/widgets.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<DashboardBloc>()..add(const LoadDashboard()),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      showAppBar: false,
      backgroundColor: AppColors.backgroundGrey,
      body: SafeArea(
        left: false,
        right: false,
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading) {
              return const LoadingWidget();
            }

            if (state is DashboardError) {
              return AppErrorWidget(
                message: state.message,
                onRetry: () {
                  context.read<DashboardBloc>().add(const LoadDashboard());
                },
              );
            }

            return ListView.builder(
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              itemCount: 7,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return const SearchBarSection();
                  case 1:
                    return const ServiceGridSection();
                  case 2:
                    return const PaymentSection();
                  case 3:
                    return const LearnMoreSection();
                  case 4:
                    return const GrabUnlimitedSection();
                  case 5:
                    return const DiscoverSection();
                  case 6:
                    return const HotSpotsSection();
                  default:
                    return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
      bottomNavigationBar: const DashboardBottomNavBar(),
    );
  }
}