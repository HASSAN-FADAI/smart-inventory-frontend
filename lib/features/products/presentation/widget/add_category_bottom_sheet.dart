import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/products/presentation/cubit/products_cubit.dart';
import 'package:inventory_managment/shared/custom_text.dart';
import 'package:inventory_managment/shared/custom_text_field.dart';

class AddCategoryBottomSheet extends StatefulWidget {
  const AddCategoryBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const AddCategoryBottomSheet(),
      ),
    );
  }

  @override
  State<AddCategoryBottomSheet> createState() => _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState extends State<AddCategoryBottomSheet> {
  final _categoryController = TextEditingController();
  bool _isSubmitting = false;

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
                  onPressed: _isSubmitting
                      ? null
                      : () => Navigator.pop(context),
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
                  onPressed: _isSubmitting
                      ? null
                      : () async {
                          final name = _categoryController.text.trim();
                          if (name.isEmpty) return;

                          setState(() => _isSubmitting = true);
                          final success = await context
                              .read<ProductsCubit>()
                              .addCategory(name: name);
                          if (!mounted) return;
                          setState(() => _isSubmitting = false);

                          if (success) {
                            Navigator.pop(context);
                          }
                        },
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const CustomText(
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
