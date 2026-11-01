// lib/features/customers/presentation/widgets/add_customer_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/shared/custom_text.dart';
import 'package:inventory_managment/shared/custom_text_field.dart';

class AddCustomerBottomSheet extends StatefulWidget {
  const AddCustomerBottomSheet({super.key});

  @override
  State<AddCustomerBottomSheet> createState() => _AddCustomerBottomSheetState();
}

class _AddCustomerBottomSheetState extends State<AddCustomerBottomSheet> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Center(
            child: CustomText(
              text: 'إضافة عميل جديد',
              size: 18,
              weight: FontWeight.bold,
            ),
          ),
          const Gap(20),
          CustomTextField(
            hintText: 'اسم العميل',
            isPassword: false,
            controller: _nameController,
            icon: const Icon(Icons.person_outline),
            prefixColor: AppColors.primary,
          ),
          const Gap(12),
          CustomTextField(
            hintText: 'رقم الهاتف',
            isPassword: false,
            controller: _phoneController,
            icon: const Icon(Icons.phone_outlined),
            prefixColor: AppColors.primary,
          ),
          const Gap(25),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: const CustomText(
                text: 'حفظ العميل',
                color: Colors.white,
                size: 16,
                weight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
