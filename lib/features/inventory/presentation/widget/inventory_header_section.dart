import 'package:flutter/material.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class InventoryHeaderSection extends StatelessWidget {
  const InventoryHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Icon(Icons.inventory_2_outlined, color: AppColors.primary),
        CustomText(
          text: 'سجل حركات وواردات المخزن',
          size: 16,
          weight: FontWeight.bold,
        ),
      ],
    );
  }
}
