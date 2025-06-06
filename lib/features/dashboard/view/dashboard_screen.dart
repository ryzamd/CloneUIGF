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
      body: BlocBuilder<DashboardBloc, DashboardState>(
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

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Search Bar as SliverAppBar - co giãn khi scroll
              SliverAppBar(
                expandedHeight: 100,
                collapsedHeight: 80,
                floating: true, // Hiện khi scroll up
                snap: true, // Snap animation
                pinned: false, // Không pin ở trên
                stretch: true, // Cho phép kéo để refresh
                automaticallyImplyLeading: false,
                backgroundColor: AppColors.primaryGreen,
                onStretchTrigger: () async {
                  // Refresh functionality - bạn sẽ thêm logic refresh ở đây
                  await Future.delayed(const Duration(seconds: 1));
                  return;
                },
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [AppColors.primaryGreen, Color(0xFF00CC99)],
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withValues(alpha: 0.3),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.qr_code_scanner,
                                    color: AppColors.white,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Container(
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 16),
                                        const Icon(
                                          Icons.search,
                                          color: AppColors.mediumGrey,
                                          size: 24,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          'Tìm món ăn',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.copyWith(
                                            color: AppColors.textHint,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withValues(
                                      alpha: 0.3,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.person,
                                    color: AppColors.white,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Content sections
              SliverList(
                delegate: SliverChildListDelegate([
                  const ServiceGridSection(),
                  const PaymentSection(),
                  const LearnMoreSection(),
                  const GrabUnlimitedSection(),
                  const DiscoverSection(),
                  const HotSpotsSection(),
                ]),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const DashboardBottomNavBar(),
    );
  }
}
