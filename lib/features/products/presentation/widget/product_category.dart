import 'package:flutter/material.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/products/domain/entities/product.entity.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({
    super.key,
    required this.selectedIndex,
    required this.categories,
    required this.onTap,
    this.onLongPressDelete,
  });

  final int selectedIndex;
  final List<CategoryEntity> categories;
  final Function(int index) onTap;
  final Function(String categoryId)? onLongPressDelete;

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant ProductCategory oldWidget) {
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      setState(() {
        selectedIndex = widget.selectedIndex;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> displayNames = [
      'الكل',
      ...widget.categories.map((c) => c.name),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(displayNames.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onTap(index);
            },
            onLongPress: () {
              if (index == 0) return;

              final category = widget.categories[index - 1];

              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const CustomText(
                    text: 'حذف الفئة',
                    weight: FontWeight.bold,
                    size: 18,
                  ),
                  content: CustomText(
                    text: 'هل أنت متأكد من حذف فئة "${category.name}"؟',
                    size: 16,
                  ),
                  actionsAlignment: MainAxisAlignment.start,
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const CustomText(
                        text: 'إلغاء',
                        color: Colors.grey,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        if (index == 0 || widget.onLongPressDelete == null) {
                          return;
                        }
                      },
                      child: const CustomText(text: 'حذف', color: Colors.white),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? AppColors.primaryDark
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: CustomText(
                text: displayNames[index],
                color: selectedIndex == index
                    ? AppColors.textSecondry
                    : AppColors.textPrimary,
                size: 12,
                weight: FontWeight.w800,
              ),
            ),
          );
        }),
      ),
    );
  }
}
