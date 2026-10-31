// lib/features/suppliers/presentation/views/suppliers_management_view.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/dashboard/widget/search_field.dart';
import 'package:inventory_managment/features/supplier/widget/add_supplier_bottom_sheet.dart';
import 'package:inventory_managment/features/supplier/widget/supplier_card.dart';
import 'package:inventory_managment/shared/Custom_drawer.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class SuppliersManagementView extends StatefulWidget {
  const SuppliersManagementView({super.key});

  @override
  State<SuppliersManagementView> createState() =>
      _SuppliersManagementViewState();
}

class _SuppliersManagementViewState extends State<SuppliersManagementView> {
  final suppliers = [
    {
      'name': 'أحمد التميمي',
      'company': 'مؤسسة التوريدات الحديثة',
      'phone': '0501234567',
      'productsCount': '14 منتج',
    },
    {
      'name': 'شركة الزيوت الكبرى',
      'company': 'الزيوت المتقدمة',
      'phone': '0559876543',
      'productsCount': '8 منتجات',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      endDrawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const CustomText(
          text: 'إدارة الموردين',
          size: 18,
          weight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SearchField(),
            const Gap(20),
            const CustomText(
              text: 'قائمة الموردين',
              size: 16,
              weight: FontWeight.bold,
            ),
            const Gap(12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: suppliers.length,
              separatorBuilder: (context, index) => const Gap(12),
              itemBuilder: (context, index) {
                final sup = suppliers[index];
                return SupplierCard(
                  name: sup['name']!,
                  company: sup['company']!,
                  phone: sup['phone']!,
                  productsCount: sup['productsCount']!,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AddSupplierBottomSheet(),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
