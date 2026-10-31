// lib/features/sales/presentation/widgets/order_history_app_bar.dart
import 'package:flutter/material.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class OrderHistoryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const OrderHistoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: const CustomText(
        text: 'سجل المبيعات والفواتير',
        size: 18,
        weight: FontWeight.bold,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
