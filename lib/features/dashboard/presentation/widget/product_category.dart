import 'package:flutter/material.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class ProductCategory extends StatefulWidget {
  const ProductCategory({
    super.key,
    required this.selectedIndex,
    required this.category,
    required this.onTap,
  });
  final int selectedIndex;
  final List category;
  final Function(int index) onTap;
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.category.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onTap(index);
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? AppColors.primaryDark
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: CustomText(
                text: widget.category[index],
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
