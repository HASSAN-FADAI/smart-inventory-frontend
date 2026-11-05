import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class LowStockSection extends StatelessWidget {
  const LowStockSection({
    super.key,
    required this.lowStockItems,
    this.onUpdatePressed,
  });

  final List lowStockItems;
  final Function(String id)? onUpdatePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondry,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              CustomText(
                text: 'تنبيهات المخزون المنخفض',
                weight: FontWeight.bold,
                size: 16,
              ),
              Gap(8),
              Icon(Icons.warning_amber_rounded, color: Colors.red, size: 20),
            ],
          ),
          const Gap(15),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: lowStockItems.length,
            separatorBuilder: (context, index) => const Divider(height: 25),
            itemBuilder: (context, index) {
              final item = lowStockItems[index];
              return _buildStockItem(
                title: item['title'] ?? '',
                minText: item['minText'] ?? '',
                progress: item['progress'] ?? 0.0,
                onTap: () => onUpdatePressed?.call(item['id'] ?? ''),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStockItem({
    required String title,
    required String minText,
    required double progress,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 0,
                ),
                minimumSize: const Size(70, 30),
              ),
              child: const CustomText(text: 'تحديث المخزون', size: 13),
            ),
            CustomText(text: title, size: 13, weight: FontWeight.w600),
          ],
        ),
        const Gap(6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(text: minText, size: 11, color: Colors.grey),
            SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade200,
                color: Colors.red,
                minHeight: 5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
