// lib/features/sales/presentation/widgets/order_history_list_section.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'order_card.dart';

class OrderHistoryListSection extends StatelessWidget {
  const OrderHistoryListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        'id': 'فاتورة #105',
        'date': '2026-10-31 11:20',
        'total': '450.00',
        'count': '3',
        'status': 'مكتملة',
      },
      {
        'id': 'فاتورة #104',
        'date': '2026-10-30 15:10',
        'total': '120.50',
        'count': '1',
        'status': 'مكتملة',
      },
      {
        'id': 'فاتورة #103',
        'date': '2026-10-29 09:45',
        'total': '890.00',
        'count': '5',
        'status': 'مكتملة',
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: orders.length,
      separatorBuilder: (context, index) => const Gap(12),
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCard(
          orderId: order['id']!,
          date: order['date']!,
          totalAmount: order['total']!,
          itemsCount: order['count']!,
          status: order['status']!,
          onTap: () {
            // لاحقاً لعرض تفاصيل الفاتورة أو طباعتها
          },
        );
      },
    );
  }
}
