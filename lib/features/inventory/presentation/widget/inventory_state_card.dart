import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class InventoryStatCard extends StatelessWidget {
  const InventoryStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
  });

  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomText(text: title, size: 15, color: Colors.grey.shade600),
            const Gap(8),
            CustomText(
              text: value,
              size: 20,
              weight: FontWeight.bold,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
