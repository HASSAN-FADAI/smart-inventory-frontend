import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/features/inventory/presentation/widget/inventory_state_card.dart';

class InventoryStatsRow extends StatelessWidget {
  const InventoryStatsRow({
    super.key,
    required this.totalIn,
    required this.totalOut,
  });

  final int totalIn;
  final int totalOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InventoryStatCard(
          title: 'إجمالي الوارد',
          value: '+$totalIn',
          color: Colors.green,
        ),
        const Gap(10),
        InventoryStatCard(
          title: 'إجمالي الصادر',
          value: '-$totalOut',
          color: Colors.orange,
        ),
      ],
    );
  }
}
