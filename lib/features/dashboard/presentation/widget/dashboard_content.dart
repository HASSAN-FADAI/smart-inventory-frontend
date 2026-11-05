import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/features/dashboard/domain/entities/dashboard_entity.dart';
import 'package:inventory_managment/features/dashboard/presentation/widget/custom_card.dart';
import 'package:inventory_managment/features/dashboard/presentation/widget/low_stock_section.dart';
import 'package:inventory_managment/features/dashboard/presentation/widget/recent_sales_table.dart';

class DashboardContentWidget extends StatelessWidget {
  final DashboardEntity data;

  const DashboardContentWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // تحويل قائمة المنتجات منخفضة المخزون لتناسب ويدجت LowStockSection
    final lowStockMapped = data.lowStockItems.map((item) {
      return {
        'id': item.id,
        'title': '${item.name} - الكمية: ${item.stockQuantity}',
        'minText': 'Minimum: ${item.minStockLevel}',
        'progress': item.progress,
      };
    }).toList();

    // تحويل قائمة أحدث المبيعات لتناسب ويدجت RecentSalesTable
    final recentSalesMapped = data.recentSales.map((sale) {
      return {
        'id': sale.id,
        'client': sale.client,
        'products': sale.products,
        'date': sale.date.length >= 16
            ? sale.date.substring(0, 16).replaceFirst('T', ' ')
            : sale.date,
        'total': '${sale.total} SAR',
        'status': sale.status,
      };
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 850;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              isMobile
                  ? Column(
                      children: [
                        SizedBox(
                          height: 160,
                          child: CustomCard(
                            title: 'المنتجات منخفضة المخزون',
                            value: '${data.lowStockItemsCount} منتج',
                            subtitle: 'يحتاج لإعادة طلب',
                            icon: const Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red,
                            ),
                            backgroundIconColor: const Color(0xFFFDE8E8),
                            iconColor: Colors.red,
                          ),
                        ),
                        const Gap(15),
                        SizedBox(
                          height: 160,
                          child: CustomCard(
                            title: 'عدد المنتجات',
                            value: '${data.totalProducts} منتج',
                            subtitle: '${data.totalCategories} أصناف',
                            icon: const Icon(
                              Icons.inventory_2_outlined,
                              color: Colors.blue,
                            ),
                            backgroundIconColor: const Color(0xFFE0F2FE),
                            iconColor: Colors.blue,
                          ),
                        ),
                        const Gap(15),
                        SizedBox(
                          height: 160,
                          child: CustomCard(
                            title: 'إجمالي المبيعات اليومية',
                            value: '${data.dailySalesTotal} SAR',
                            subtitle:
                                'قيمة المخزون: ${data.totalInventoryValue}',
                            icon: const Icon(
                              Icons.trending_up,
                              color: Colors.green,
                            ),
                            backgroundIconColor: const Color(0xFFDCFCE7),
                            iconColor: Colors.green,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: CustomCard(
                            title: 'المنتجات منخفضة المخزون',
                            value: '${data.lowStockItemsCount} منتج',
                            subtitle: 'يحتاج لإعادة طلب',
                            icon: const Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red,
                            ),
                            backgroundIconColor: const Color(0xFFFDE8E8),
                            iconColor: Colors.red,
                          ),
                        ),
                        const Gap(15),
                        Expanded(
                          child: CustomCard(
                            title: 'عدد المنتجات',
                            value: '${data.totalProducts} منتج',
                            subtitle: '${data.totalCategories} أصناف',
                            icon: const Icon(
                              Icons.inventory_2_outlined,
                              color: Colors.blue,
                            ),
                            backgroundIconColor: const Color(0xFFE0F2FE),
                            iconColor: Colors.blue,
                          ),
                        ),
                        const Gap(15),
                        Expanded(
                          child: CustomCard(
                            title: 'إجمالي المبيعات اليومية',
                            value: '${data.dailySalesTotal} SAR',
                            subtitle:
                                'قيمة المخزون: ${data.totalInventoryValue}',
                            icon: const Icon(
                              Icons.trending_up,
                              color: Colors.green,
                            ),
                            backgroundIconColor: const Color(0xFFDCFCE7),
                            iconColor: Colors.green,
                          ),
                        ),
                      ],
                    ),
              const Gap(25),

              isMobile
                  ? Column(
                      children: [
                        LowStockSection(
                          lowStockItems: lowStockMapped,
                          onUpdatePressed: (id) {},
                        ),
                        const Gap(20),
                        RecentSalesTable(salesList: recentSalesMapped),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 430,
                          child: LowStockSection(
                            lowStockItems: lowStockMapped,
                            onUpdatePressed: (id) {},
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 860,
                          child: RecentSalesTable(salesList: recentSalesMapped),
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}
