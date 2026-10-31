// lib/features/sales/presentation/views/order_history_view.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/dashboard/widget/search_field.dart';
import 'package:inventory_managment/features/order_history/widget/order_history_app_bar.dart';
import 'package:inventory_managment/features/order_history/widget/order_history_list_section.dart';
import 'package:inventory_managment/shared/Custom_drawer.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldPrimary,
      endDrawer: const CustomDrawer(),
      appBar: OrderHistoryAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            SearchField(),
            Gap(20),
            CustomText(
              text: 'الفواتير السابقة',
              size: 16,
              weight: FontWeight.bold,
            ),
            Gap(12),
            OrderHistoryListSection(),
          ],
        ),
      ),
    );
  }
}
