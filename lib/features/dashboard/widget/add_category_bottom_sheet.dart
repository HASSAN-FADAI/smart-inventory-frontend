// lib/features/dashboard/widget/add_category_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/shared/custom_text.dart';
import 'package:inventory_managment/shared/custom_text_field.dart';

class AddCategoryBottomSheet extends StatefulWidget {
  const AddCategoryBottomSheet({super.key});

  @override
  State<AddCategoryBottomSheet> createState() => _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState extends State<AddCategoryBottomSheet> {
  final _categoryController = TextEditingController();

  @override
  void dispose() {
    _categoryController.dispose();
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
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Gap(15),
          const Center(
            child: CustomText(
              text: 'إضافة فئة جديدة',
              size: 18,
              weight: FontWeight.bold,
            ),
          ),
          const Gap(20),

          const CustomText(
            text: 'اسم الفئة الجديدة:',
            size: 14,
            weight: FontWeight.w600,
          ),
          const Gap(6),
          CustomTextField(
            hintText: 'أدخل اسم الفئة الجديدة',
            isPassword: false,
            controller: _categoryController,
            icon: const Icon(Icons.category_outlined),
            prefixColor: AppColors.primary,
          ),
          const Gap(25),

          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const CustomText(
                    text: 'إلغاء',
                    color: Colors.grey,
                    size: 15,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
              const Gap(10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // هنا يتم حفظ الفئة الجديدة وإرسالها للباك إند
                    Navigator.pop(context);
                  },
                  child: const CustomText(
                    text: 'حفظ',
                    color: Colors.white,
                    size: 15,
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
