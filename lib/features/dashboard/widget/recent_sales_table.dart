import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class RecentSalesTable extends StatelessWidget {
  const RecentSalesTable({super.key, required this.salesList});

  final List salesList;

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
          const CustomText(
            text: 'أحدث فواتير البيع',
            weight: FontWeight.bold,
            size: 16,
          ),
          const Gap(3),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('الحالة')),
                DataColumn(label: Text('الإجمالي')),
                DataColumn(label: Text('التاريخ')),
                DataColumn(label: Text('المنتجات')),
                DataColumn(label: Text('العميل')),
                DataColumn(label: Text('رقم الفاتورة')),
              ],
              rows: salesList
                  .map(
                    (sale) => _buildRow(
                      sale['id'] ?? '',
                      sale['client'] ?? '',
                      sale['products'] ?? '',
                      sale['date'] ?? '',
                      sale['total'] ?? '',
                      sale['status'] ?? '',
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(
    String id,
    String client,
    String products,
    String date,
    String total,
    String status,
  ) {
    return DataRow(
      cells: [
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: const TextStyle(color: Colors.green, fontSize: 12),
            ),
          ),
        ),
        DataCell(Text(total)),
        DataCell(Text(date)),
        DataCell(Text(products)),
        DataCell(Text(client)),
        DataCell(Text(id)),
      ],
    );
  }
}
