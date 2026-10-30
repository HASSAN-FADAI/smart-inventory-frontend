import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/dashboard/views/Product_Management_view.dart';
import 'package:inventory_managment/features/dashboard/views/dashboard_view.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primary,
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: CustomText(
                text: 'نظام إدارة المخزون\nالذكية',
                color: Colors.white,
                weight: FontWeight.bold,
                size: 16,
              ),
            ),
            const Divider(color: Colors.white24, height: 1),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  _tile(
                    context,
                    icon: Icons.home_outlined,
                    title: 'الرئيسية',

                    destination: DashboardView(),
                  ),

                  _tile(
                    context,
                    icon: Icons.inventory_2_outlined,
                    title: 'المنتجات',
                    destination: const ProductManagementView(),
                  ),

                  _tile(
                    context,
                    icon: Icons.shopping_cart_outlined,
                    title: 'المبيعات',
                    // destination: const SalesView(),
                  ),

                  _tile(
                    context,
                    icon: Icons.people_outline,
                    title: 'العملاء',
                    //  destination: const CustomersView()
                  ),
                  _tile(
                    context,
                    icon: Icons.local_shipping_outlined,
                    title: 'الموردين',
                    //  destination: const SuppliersView()
                  ),

                  const Divider(color: Colors.white24),

                  _tile(
                    context,
                    icon: Icons.bar_chart,
                    title: 'التقارير',
                    // destination: const ReportsView(),
                  ),
                  _tile(
                    context,
                    icon: Icons.settings_outlined,
                    title: 'الإعدادات',
                    // destination: const SettingsView(),
                  ),
                ],
              ),
            ),

            const Divider(color: Colors.white24, height: 1),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    text: 'hassanfadai',
                    color: Colors.white,
                    weight: FontWeight.bold,
                  ),
                  Gap(10),
                  CircleAvatar(radius: 14, child: Icon(Icons.person, size: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة مساعدة (Helper Method) لإدارة الانتقال وإغلاق القائمة تلقائياً
  Widget _tile(
    BuildContext context, {
    required IconData icon,
    required String title,
    bool isActive = false,
    Widget? destination,
  }) {
    return ListTile(
      selected: isActive,
      selectedTileColor: Colors.white12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      leading: Icon(icon, color: Colors.white, size: 20),
      title: Align(
        alignment: Alignment.centerRight,
        child: CustomText(text: title, color: Colors.white, size: 14),
      ),
      onTap: () {
        // 1. إغلاق الـ Drawer أولاً
        Navigator.pop(context);

        // 2. الانتقال للصفحة المحددة إذا كانت موجودة وليست الصفحة الحالية
        if (destination != null && !isActive) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        }
      },
    );
  }
}
