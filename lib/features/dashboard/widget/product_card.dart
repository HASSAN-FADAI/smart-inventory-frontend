import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.name,
    required this.sku,
    required this.category,
    required this.salePrice,
    required this.costPrice,
    required this.quantity,
    required this.minQuantity,
    this.isAdmin = false,
    this.isLowStock = false,
    this.onEdit,
    this.onDelete,
    this.onTrash,
  });

  final String name;
  final String sku;
  final String category;
  final String salePrice;
  final String costPrice;
  final String quantity;
  final String minQuantity;
  final bool isAdmin;
  final bool isLowStock;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTrash;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isLowStock
            ? Border.all(color: Colors.red.shade300, width: 1.5)
            : null,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isAdmin)
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const CustomText(
                  text: 'ADMIN',
                  color: Colors.white,
                  size: 10,
                  weight: FontWeight.bold,
                ),
              ),
            ),

          CustomText(text: name, weight: FontWeight.bold, size: 16),
          const Gap(10),
          CustomText(text: 'SKU: $sku', color: Colors.grey.shade600, size: 11),
          const Gap(10),

          _buildRowDetail('القسم', category),
          const Gap(20),
          _buildRowDetail('سعر البيع', '$salePrice SAR'),
          const Gap(20),
          if (isAdmin) _buildRowDetail('التكلفة', '$costPrice SAR'),

          _buildRowDetail('الكمية', 'Qty: $quantity', isWarning: isLowStock),
          const Gap(20),
          _buildRowDetail('الحد الأدنى', 'Min: $minQuantity'),
          const Gap(10),

          if (isLowStock) ...[
            const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomText(
                  text: 'تنبيه المخزون المنخفض',
                  color: Colors.red,
                  size: 11,
                  weight: FontWeight.bold,
                ),
                Gap(4),
                Icon(Icons.warning_amber_rounded, color: Colors.red, size: 16),
              ],
            ),
          ],

          const Divider(height: 15),
          Row(
            children: [
              TextButton(
                onPressed: onTrash,
                child: const CustomText(
                  text: ' شراء',
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(
                  Icons.edit_outlined,
                  color: Colors.blue,
                  size: 25,
                ),
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 25,
                ),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRowDetail(String label, String value, {bool isWarning = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: value,
            weight: FontWeight.w600,
            size: 20,
            color: isWarning ? Colors.red : Colors.black,
          ),
          CustomText(text: label, color: Colors.grey.shade600, size: 20),
        ],
      ),
    );
  }
}
