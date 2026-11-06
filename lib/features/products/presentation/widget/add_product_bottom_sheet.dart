import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/products/domain/entities/product.entity.dart';
import 'package:inventory_managment/features/products/presentation/cubit/products_cubit.dart';
import 'package:inventory_managment/features/products/presentation/widget/custom_product_text_field.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class AddProductBottomSheet extends StatefulWidget {
  final List<CategoryEntity> categories;
  final ProductEntity? productToEdit;

  const AddProductBottomSheet({
    super.key,
    required this.categories,
    this.productToEdit,
  });

  static Future<void> show(
    BuildContext context,
    List<CategoryEntity> categories, {
    ProductEntity? productToEdit,
  }) {
    final cubit = context.read<ProductsCubit>();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: AddProductBottomSheet(
          categories: categories,
          productToEdit: productToEdit,
        ),
      ),
    );
  }

  @override
  State<AddProductBottomSheet> createState() => _AddProductBottomSheetState();
}

class _AddProductBottomSheetState extends State<AddProductBottomSheet> {
  final _nameController = TextEditingController();
  final _skuController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();
  final _costPriceController = TextEditingController();
  final _stockController = TextEditingController();
  final _minStockController = TextEditingController(text: '5');

  String? selectedCategoryId;
  bool _isSubmitting = false;

  bool get isEditMode => widget.productToEdit != null;

  @override
  void initState() {
    super.initState();
    if (isEditMode) {
      final product = widget.productToEdit!;
      _nameController.text = product.name;
      _skuController.text = product.sku;
      _descController.text = product.description ?? '';
      _priceController.text = product.price.toString();
      _costPriceController.text = product.costPrice.toString();
      _stockController.text = product.stockQuantity.toString();
      _minStockController.text = product.minStockLevel.toString();

      if (widget.categories.any((c) => c.id == product.categoryId)) {
        selectedCategoryId = product.categoryId;
      }
    }
  }

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

  Future<void> _onSubmit() async {
    if (_nameController.text.trim().isEmpty ||
        _skuController.text.trim().isEmpty ||
        selectedCategoryId == null) {
      return;
    }

    setState(() => _isSubmitting = true);

    final cubit = context.read<ProductsCubit>();
    bool success;

    if (isEditMode) {
      success = await cubit.updateProduct(widget.productToEdit!.id, {
        'name': _nameController.text.trim(),
        'sku': _skuController.text.trim(),
        'description': _descController.text.trim(),
        'price': double.tryParse(_priceController.text) ?? 0.0,
        'costPrice': double.tryParse(_costPriceController.text) ?? 0.0,
        'stockQuantity': int.tryParse(_stockController.text) ?? 0,
        'minStockLevel': int.tryParse(_minStockController.text) ?? 5,
        'categoryId': selectedCategoryId,
      });
    } else {
      success = await cubit.addProduct(
        name: _nameController.text.trim(),
        sku: _skuController.text.trim(),
        description: _descController.text.trim(),
        price: double.tryParse(_priceController.text) ?? 0.0,
        costPrice: double.tryParse(_costPriceController.text) ?? 0.0,
        stockQuantity: int.tryParse(_stockController.text) ?? 0,
        minStockLevel: int.tryParse(_minStockController.text) ?? 5,
        categoryId: selectedCategoryId!,
      );
    }

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (success) {
      Navigator.pop(context);
    }
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
            Center(
              child: CustomText(
                text: isEditMode ? 'تعديل المنتج' : 'إضافة منتج جديد',
                size: 18,
                weight: FontWeight.bold,
              ),
            ),
            const Gap(20),
            CustomProductTextField(
              label: 'اسم المنتج (name)',
              controller: _nameController,
            ),
            const Gap(12),
            CustomProductTextField(
              label: 'الكود الفريد (SKU)',
              controller: _skuController,
            ),
            const Gap(12),
            CustomProductTextField(
              label: 'وصف المنتج (description)',
              controller: _descController,
              maxLines: 2,
            ),
            const Gap(12),
            CustomProductTextField(
              label: 'سعر البيع (price)',
              controller: _priceController,
              isNumber: true,
            ),
            const Gap(12),
            CustomProductTextField(
              label: 'التكلفة (costPrice)',
              controller: _costPriceController,
              isNumber: true,
            ),
            const Gap(12),
            CustomProductTextField(
              label: 'الكمية الأولية (stockQuantity)',
              controller: _stockController,
              isNumber: true,
            ),
            const Gap(12),
            CustomProductTextField(
              label: 'الحد الأدنى للتنبيه (minStockLevel)',
              controller: _minStockController,
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
              items: widget.categories.map((cat) {
                return DropdownMenuItem<String>(
                  value: cat.id,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(cat.name),
                  ),
                );
              }).toList(),
              onChanged: (val) => setState(() => selectedCategoryId = val),
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
                onPressed: _isSubmitting ? null : _onSubmit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : CustomText(
                        text: isEditMode ? 'حفظ التعديلات' : 'حفظ المنتج',
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
}
