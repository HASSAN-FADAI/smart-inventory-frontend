// lib/features/reports/presentation/views/reports_view.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/report/widget/report_stat_card.dart';
import 'package:inventory_managment/features/report/widget/sales_line_chart_card.dart';
import 'package:inventory_managment/shared/Custom_drawer.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldPrimary,
      endDrawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const CustomText(
          text: 'التقارير والإحصائيات',
          size: 18,
          weight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const CustomText(
              text: 'نظرة عامة على الأداء',
              size: 16,
              weight: FontWeight.bold,
            ),
            const Gap(12),
            Row(
              children: const [
                ReportStatCard(
                  title: 'إجمالي المبيعات',
                  value: '14,250 SAR',
                  icon: Icons.trending_up,
                  color: Colors.green,
                ),
                Gap(10),
                ReportStatCard(
                  title: 'صافي الأرباح',
                  value: '4,890 SAR',
                  icon: Icons.account_balance_wallet_outlined,
                  color: AppColors.primary,
                ),
              ],
            ),
            const Gap(15),
            Row(
              children: const [
                ReportStatCard(
                  title: 'حركات المخزن',
                  value: '156 حركة',
                  icon: Icons.inventory_2_outlined,
                  color: Colors.orange,
                ),
                Gap(10),
                ReportStatCard(
                  title: 'العملاء الجدد',
                  value: '+24 عميل',
                  icon: Icons.people_outline,
                  color: Colors.blue,
                ),
              ],
            ),
            const Gap(25),
            const SalesLineChartCard(),
          ],
        ),
      ),
    );
  }
}
