// lib/features/dashboard/widget/add_product_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class AddProductBottomSheet extends StatefulWidget {
  const AddProductBottomSheet({super.key});

  @override
  State<AddProductBottomSheet> createState() => _AddProductBottomSheetState();
}

class _AddProductBottomSheetState extends State<AddProductBottomSheet> {
  // حقول البيانات المطابقة لـ Product Entity في الباك إند
  final _nameController = TextEditingController();
  final _skuController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _costPriceController = TextEditingController();
  final _stockController = TextEditingController();
  final _minStockController = TextEditingController();
  String? selectedCategoryId;

  // قائمة الفئات التجريبية (مرتبطة بـ categoryId)
  final List categories = [
    {'id': '1', 'name': 'المشروبات'},
    {'id': '2', 'name': 'الإلكترونيات'},
    {'id': '3', 'name': 'الخضروات'},
    {'id': '4', 'name': 'اللحوم'},
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _descController.dispose();
    _priceController.dispose();
    _costPriceController.dispose();
    _stockController.dispose();
    _minStockController.dispose();
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
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
                text: 'إضافة منتج جديد',
                size: 18,
                weight: FontWeight.bold,
              ),
            ),
            const Gap(20),

            _buildTextField('اسم المنتج (name)', _nameController),
            const Gap(12),
            _buildTextField('الكود الفريد (SKU)', _skuController),
            const Gap(12),
            _buildTextField(
              'وصف المنتج (description)',
              _descController,
              maxLines: 2,
            ),
            const Gap(12),
            _buildTextField(
              'سعر البيع (price)',
              _priceController,
              isNumber: true,
            ),
            const Gap(12),
            _buildTextField(
              'التكلفة (costPrice)',
              _costPriceController,
              isNumber: true,
            ),
            const Gap(12),
            _buildTextField(
              'الكمية الأولية (stockQuantity)',
              _stockController,
              isNumber: true,
            ),
            const Gap(12),
            _buildTextField(
              'الحد الأدنى للتنبيه (minStockLevel)',
              _minStockController,
              isNumber: true,
            ),
            const Gap(12),

            const CustomText(
              text: 'اختيار الفئة (Category)',
              size: 14,
              weight: FontWeight.w600,
            ),
            const Gap(6),
            DropdownButtonFormField<String>(
              initialValue: selectedCategoryId,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              hint: const Align(
                alignment: Alignment.centerRight,
                child: Text('اختر الفئة'),
              ),
              items: categories.map((cat) {
                return DropdownMenuItem<String>(
                  value: cat['id'],
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(cat['name']!),
                  ),
                );
              }).toList(),
              onChanged: (val) {
                setState(() {
                  selectedCategoryId = val;
                });
              },
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
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const CustomText(
                  text: 'حفظ المنتج',
                  color: Colors.white,
                  size: 16,
                  weight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isNumber = false,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomText(text: label, size: 14, weight: FontWeight.w600),
        const Gap(6),
        TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
