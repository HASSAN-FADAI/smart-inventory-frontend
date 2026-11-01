import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class ReportStatCard extends StatelessWidget {
  const ReportStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                CustomText(text: title, size: 12, color: Colors.grey.shade600),
              ],
            ),
            const Gap(12),
            CustomText(
              text: value,
              size: 18,
              weight: FontWeight.bold,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}
