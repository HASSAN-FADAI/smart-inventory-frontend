import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/dashboard/widget/Custom_drawer.dart';
import 'package:inventory_managment/features/dashboard/widget/custom_card.dart';
import 'package:inventory_managment/features/dashboard/widget/low_stock_section.dart';
import 'package:inventory_managment/features/dashboard/widget/recent_sales_table.dart';
import 'package:inventory_managment/features/dashboard/widget/search_field.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldPrimary,
      endDrawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.secondry,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {},
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Text(
                      '3',
                      style: TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline),
              onPressed: () {},
            ),
            const CircleAvatar(radius: 14, child: Icon(Icons.person, size: 16)),
            const Gap(10),
            Expanded(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 180),
                child: const SearchField(),
              ),
            ),
            const Spacer(),
            const CustomText(text: 'لوحة تحكم المشرف - نظرة عامة', size: 15),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 850;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const CustomText(
                  text: 'الرئيسية',
                  weight: FontWeight.bold,
                  size: 20,
                ),
                const Gap(20),

                // بطاقات الإحصائيات (تتجاوب تلقائياً مع الشاشة)
                isMobile
                    ? Column(
                        children: const [
                          SizedBox(
                            height: 160,
                            child: CustomCard(
                              title: 'المنتجات منخفضة المخزون',
                              value: '17 منتج',
                              subtitle: 'يحتاج لإعادة طلب',
                              icon: Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.red,
                              ),
                              backgroundIconColor: Color(0xFFFDE8E8),
                              iconColor: Colors.red,
                            ),
                          ),
                          Gap(15),
                          SizedBox(
                            height: 160,
                            child: CustomCard(
                              title: 'عدد المنتجات',
                              value: '1,248 منتج',
                              subtitle: '10 أصناف جديدة',
                              icon: Icon(
                                Icons.inventory_2_outlined,
                                color: Colors.blue,
                              ),
                              backgroundIconColor: Color(0xFFE0F2FE),
                              iconColor: Colors.blue,
                            ),
                          ),
                          Gap(15),
                          SizedBox(
                            height: 160,
                            child: CustomCard(
                              title: 'إجمالي المبيعات اليومية',
                              value: '2,850.50 SAR',
                              subtitle: '+12% منذ أمس',
                              icon: Icon(
                                Icons.trending_up,
                                color: Colors.green,
                              ),
                              backgroundIconColor: Color(0xFFDCFCE7),
                              iconColor: Colors.green,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: const [
                          CustomCard(
                            title: 'المنتجات منخفضة المخزون',
                            value: '17 منتج',
                            subtitle: 'يحتاج لإعادة طلب',
                            icon: Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.red,
                            ),
                            backgroundIconColor: Color(0xFFFDE8E8),
                            iconColor: Colors.red,
                          ),
                          Gap(15),
                          CustomCard(
                            title: 'عدد المنتجات',
                            value: '1,248 منتج',
                            subtitle: '10 أصناف جديدة',
                            icon: Icon(
                              Icons.inventory_2_outlined,
                              color: Colors.blue,
                            ),
                            backgroundIconColor: Color(0xFFE0F2FE),
                            iconColor: Colors.blue,
                          ),
                          Gap(15),
                          CustomCard(
                            title: 'إجمالي المبيعات اليومية',
                            value: '2,850.50 SAR',
                            subtitle: '+12% منذ أمس',
                            icon: Icon(Icons.trending_up, color: Colors.green),
                            backgroundIconColor: Color(0xFFDCFCE7),
                            iconColor: Colors.green,
                          ),
                        ],
                      ),
                const Gap(25),

                // قسم التنبيهات والفواتير (يتجاوب بالانتقال من صف إلى عمود)
                isMobile
                    ? Column(
                        children: [
                          LowStockSection(
                            lowStockItems: [
                              {
                                'id': '1',
                                'title': 'أيفون 15 (أسود) - الكمية: 2',
                                'minText': 'Minimum: 5',
                                'progress': 0.4,
                              },
                              {
                                'id': '2',
                                'title': 'ساعة ذكية - الكمية: 1',
                                'minText': 'Minimum: 10',
                                'progress': 0.2,
                              },
                              {
                                'id': '3',
                                'title': 'شاحن لاسلكي - الكمية: 8',
                                'minText': 'Minimum: 15',
                                'progress': 0.6,
                              },
                            ],
                            onUpdatePressed: (id) {},
                          ),
                          const Gap(20),
                          RecentSalesTable(
                            salesList: [
                              {
                                'id': 'INV-00451',
                                'client': 'يوسف خالد',
                                'products': 'سماعات، لابتوب',
                                'date': '2024-05-15 14:30',
                                'total': '480 SAR',
                                'status': 'تم الدفع',
                              },
                              {
                                'id': 'INV-00452',
                                'client': 'يوسف خالد',
                                'products': 'سماعات، لابتوب',
                                'date': '2024-05-15 14:30',
                                'total': '480 SAR',
                                'status': 'تم الدفع',
                              },
                            ],
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 430,
                            child: LowStockSection(
                              lowStockItems: [
                                {
                                  'id': '1',
                                  'title': 'أيفون 15 (أسود) - الكمية: 2',
                                  'minText': 'Minimum: 5',
                                  'progress': 0.4,
                                },
                                {
                                  'id': '2',
                                  'title': 'ساعة ذكية - الكمية: 1',
                                  'minText': 'Minimum: 10',
                                  'progress': 0.2,
                                },
                                {
                                  'id': '3',
                                  'title': 'شاحن لاسلكي - الكمية: 8',
                                  'minText': 'Minimum: 15',
                                  'progress': 0.6,
                                },
                              ],
                              onUpdatePressed: (id) {},
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 860,
                            child: RecentSalesTable(
                              salesList: [
                                {
                                  'id': 'INV-00451',
                                  'client': 'يوسف خالد',
                                  'products': 'سماعات، لابتوب',
                                  'date': '2024-05-15 14:30',
                                  'total': '480 SAR',
                                  'status': 'تم الدفع',
                                },
                                {
                                  'id': 'INV-00452',
                                  'client': 'يوسف خالد',
                                  'products': 'سماعات، لابتوب',
                                  'date': '2024-05-15 14:30',
                                  'total': '480 SAR',
                                  'status': 'تم الدفع',
                                },
                              ],
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
