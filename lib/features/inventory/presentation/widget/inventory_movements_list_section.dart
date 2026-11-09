import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/features/inventory/domain/entities/stock_transaction_entity.dart';
import 'package:inventory_managment/features/inventory/presentation/widget/inventory_movement_card.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class InventoryMovementsListSection extends StatelessWidget {
  const InventoryMovementsListSection({
    super.key,
    required this.selectedFilter,
    required this.movements,
  });

  final String selectedFilter;
  final List<StockTransactionEntity> movements;

  String _getTypeLabel(String type) {
    if (type == 'IN') return 'وارد (IN)';
    if (type == 'OUT') return 'صرف (OUT)';
    return 'تعديل (ADJUSTMENT)';
  }

  String _getFormattedQty(String type, int qty) {
    if (type == 'IN') return '+$qty';
    if (type == 'OUT') return '-$qty';
    return '$qty';
  }

  @override
  Widget build(BuildContext context) {
    final filtered = selectedFilter == 'ALL'
        ? movements
        : movements.where((item) => item.type == selectedFilter).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomText(
          text: 'الحركات (${filtered.length})',
          size: 15,
          weight: FontWeight.bold,
        ),
        const Gap(12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filtered.length,
          separatorBuilder: (context, index) => const Gap(10),
          itemBuilder: (context, index) {
            final item = filtered[index];
            return InventoryMovementCard(
              name: item.productName,
              type: _getTypeLabel(item.type),
              qty: _getFormattedQty(item.type, item.quantity),
              date: item.createdAt.toString().substring(0, 16),
              movementType: item.type,
            );
          },
        ),
      ],
    );
  }
}
