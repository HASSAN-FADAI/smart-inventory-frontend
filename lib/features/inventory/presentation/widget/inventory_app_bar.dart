// lib/features/inventory/presentation/widgets/inventory_app_bar.dart
import 'package:flutter/material.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class InventoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const InventoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: const CustomText(
        text: 'إدارة المخزون والحركات',
        size: 18,
        weight: FontWeight.bold,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
