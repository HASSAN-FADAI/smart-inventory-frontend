import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/features/inventory/widget/inventory_state_card.dart';

class InventoryStatsRow extends StatelessWidget {
  const InventoryStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        InventoryStatCard(
          title: 'إجمالي الوارد',
          value: '+120',
          color: Colors.green,
        ),
        Gap(10),
        InventoryStatCard(
          title: 'إجمالي الصادر',
          value: '-45',
          color: Colors.orange,
        ),
      ],
    );
  }
}
