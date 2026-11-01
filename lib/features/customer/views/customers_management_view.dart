import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/customer/widget/add_customer_bottom_sheet.dart';
import 'package:inventory_managment/features/customer/widget/customer_card.dart';
import 'package:inventory_managment/features/dashboard/widget/search_field.dart';
import 'package:inventory_managment/shared/Custom_drawer.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class CustomersManagementView extends StatelessWidget {
  const CustomersManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    final customers = [
      {'name': 'محمد عبد الله', 'phone': '0561122334', 'total': '1,250.00'},
      {
        'name': 'شركة الأمل التجارية',
        'phone': '0545566778',
        'total': '4,500.00',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.scaffoldPrimary,
      endDrawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const CustomText(
          text: 'إدارة العملاء',
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
              text: 'قائمة العملاء',
              size: 16,
              weight: FontWeight.bold,
            ),
            const Gap(12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: customers.length,
              separatorBuilder: (context, index) => const Gap(12),
              itemBuilder: (context, index) {
                final cus = customers[index];
                return CustomerCard(
                  name: cus['name']!,
                  phone: cus['phone']!,
                  totalPurchases: cus['total']!,
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
            builder: (BuildContext context) => const AddCustomerBottomSheet(),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
