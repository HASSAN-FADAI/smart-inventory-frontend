import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/features/inventory/widget/inventory_movement_card.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class InventoryMovementsListSection extends StatelessWidget {
  const InventoryMovementsListSection({
    super.key,
    required this.selectedFilter,
  });

  final String selectedFilter;

  @override
  Widget build(BuildContext context) {
    final allMovements = [
      {
        'name': 'زيت مصفاة 1لتر',
        'type': 'IN',
        'typeLabel': 'وارد (IN)',
        'qty': '+50',
        'date': '2026-10-31 10:30',
      },
      {
        'name': 'فلتر هواء سيارة',
        'type': 'OUT',
        'typeLabel': 'صرف (OUT)',
        'qty': '-4',
        'date': '2026-10-31 09:15',
      },
      {
        'name': 'إطار سيارة 16 انش',
        'type': 'ADJUSTMENT',
        'typeLabel': 'تعديل (ADJUSTMENT)',
        'qty': '-1',
        'date': '2026-10-30 16:45',
      },
    ];

    final filteredMovements = selectedFilter == 'ALL'
        ? allMovements
        : allMovements.where((item) => item['type'] == selectedFilter).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomText(
          text: 'الحركات (${filteredMovements.length})',
          size: 15,
          weight: FontWeight.bold,
        ),
        const Gap(12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredMovements.length,
          separatorBuilder: (context, index) => const Gap(10),
          itemBuilder: (context, index) {
            final item = filteredMovements[index];
            return InventoryMovementCard(
              name: item['name'] as String,
              type: item['typeLabel'] as String,
              qty: item['qty'] as String,
              date: item['date'] as String,
              movementType: item['type'] as String,
            );
          },
        ),
      ],
    );
  }
}
