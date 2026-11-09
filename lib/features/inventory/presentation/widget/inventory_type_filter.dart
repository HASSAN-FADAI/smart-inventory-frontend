// lib/features/inventory/presentation/widgets/inventory_type_filter.dart
import 'package:flutter/material.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class InventoryTypeFilter extends StatefulWidget {
  const InventoryTypeFilter({super.key, required this.onSelected});
  final Function(String type) onSelected;

  @override
  State<InventoryTypeFilter> createState() => _InventoryTypeFilterState();
}

class _InventoryTypeFilterState extends State<InventoryTypeFilter> {
  int selectedIndex = 0;
  final List filters = [
    {'label': 'الكل', 'value': 'ALL'},
    {'label': 'وارد (IN)', 'value': 'IN'},
    {'label': 'صادر (OUT)', 'value': 'OUT'},
    {'label': 'تعديل (ADJUSTMENT)', 'value': 'ADJUSTMENT'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(filters.length, (index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              widget.onSelected(filters[index]['value']!);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CustomText(
                text: filters[index]['label']!,
                size: 12,
                weight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          );
        }),
      ),
    );
  }
}
