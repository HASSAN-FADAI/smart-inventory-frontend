// lib/features/sales/presentation/widgets/order_card.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.orderId,
    required this.date,
    required this.totalAmount,
    required this.itemsCount,
    required this.status,
    this.onTap,
  });

  final String orderId;
  final String date;
  final String totalAmount;
  final String itemsCount;
  final String status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildHeaderRow(),
            const Gap(10),
            _buildDetailsRow(),
            const Divider(height: 20),
            _buildFooterRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(6),
          ),
          child: CustomText(
            text: status,
            size: 15,
            weight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        CustomText(text: orderId, size: 16, weight: FontWeight.bold),
      ],
    );
  }

  Widget _buildDetailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: 'عدد المنتجات: $itemsCount',
          size: 14,
          color: Colors.grey.shade600,
        ),
        CustomText(text: date, size: 12, color: Colors.grey.shade500),
      ],
    );
  }

  Widget _buildFooterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomText(
          text: 'عرض التفاصيل',
          size: 14,
          color: AppColors.primary,
          weight: FontWeight.bold,
        ),
        CustomText(
          text: '$totalAmount SAR',
          size: 16,
          weight: FontWeight.bold,
          color: Colors.black87,
        ),
      ],
    );
  }
}
