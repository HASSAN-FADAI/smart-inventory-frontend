import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class InventoryMovementCard extends StatelessWidget {
  const InventoryMovementCard({
    super.key,
    required this.name,
    required this.type,
    required this.qty,
    required this.date,
    required this.movementType,
  });

  final String name;
  final String type;
  final String qty;
  final String date;
  final String movementType;

  @override
  Widget build(BuildContext context) {
    final isIN = movementType == 'IN';
    final isOut = movementType == 'OUT';
    final badgeColor = isIN
        ? Colors.green
        : (isOut ? Colors.orange : Colors.blue);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomText(
              text: qty,
              size: 14,
              weight: FontWeight.bold,
              color: badgeColor,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(text: name, size: 16, weight: FontWeight.bold),
              const Gap(4),
              CustomText(text: type, size: 14, color: badgeColor),
              const Gap(2),
              CustomText(text: date, size: 13, color: Colors.grey.shade400),
            ],
          ),
        ],
      ),
    );
  }
}
