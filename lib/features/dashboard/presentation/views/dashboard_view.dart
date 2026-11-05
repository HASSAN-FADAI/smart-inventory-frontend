import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:inventory_managment/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:inventory_managment/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:inventory_managment/features/dashboard/presentation/widget/custom_card.dart';
import 'package:inventory_managment/features/dashboard/presentation/widget/dashboard_content.dart';
import 'package:inventory_managment/features/dashboard/presentation/widget/low_stock_section.dart';
import 'package:inventory_managment/features/dashboard/presentation/widget/recent_sales_table.dart';
import 'package:inventory_managment/features/dashboard/presentation/widget/search_field.dart';
import 'package:inventory_managment/shared/Custom_drawer.dart';
import 'package:inventory_managment/shared/custom_snack_bar.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().getDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldPrimary,
      endDrawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.secondry,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline),
              onPressed: () {},
            ),
            const CircleAvatar(radius: 14, child: Icon(Icons.person, size: 16)),
            const Gap(10),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 180),
                child: const SearchField(),
              ),
            ),
            const Spacer(),
            const CustomText(text: 'لوحة تحكم المشرف - نظرة عامة', size: 15),
          ],
        ),
      ),
      body: BlocConsumer<DashboardCubit, DashboardState>(
        listenWhen: (previous, current) => current is DashboardError,
        listener: (context, state) {
          if (state is DashboardError) {
            CustomSnackBar.show(
              context,
              message: state.message,
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DashboardError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(text: state.message, size: 16),
                  const Gap(15),
                  ElevatedButton(
                    onPressed: () {
                      context.read<DashboardCubit>().getDashboardData();
                    },
                    child: const Text('إعادة المحاولة'),
                  ),
                ],
              ),
            );
          } else if (state is DashboardSuccess) {
            final data = state.dashboardData;
            return DashboardContentWidget(data: data);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
