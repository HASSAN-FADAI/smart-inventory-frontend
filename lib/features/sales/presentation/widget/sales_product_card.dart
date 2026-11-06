import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/shared/custom_button.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class SalesProductCard extends StatelessWidget {
  const SalesProductCard({
    super.key,
    required this.name,
    required this.sku,
    required this.category,
    required this.salePrice,
    required this.costPrice,
    required this.quantity,
    required this.isAdmin,
    required this.onAddTOCart,
    required this.onIncrement,
    required this.onDecrement,
  });

  final String name;
  final String sku;
  final String category;
  final String salePrice;
  final String costPrice;
  final int quantity;
  final bool isAdmin;
  final VoidCallback onAddTOCart;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isAdmin)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
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
                )
              else
                const SizedBox(),
              CustomText(text: name, weight: FontWeight.bold, size: 20),
            ],
          ),
          const Gap(4),
          Align(
            alignment: Alignment.centerRight,
            child: CustomText(
              text: 'SKU: $sku',
              color: Colors.grey.shade600,
              size: 12,
            ),
          ),
          const Gap(8),

          _buildRowDetail('القسم', category),
          _buildRowDetail('سعر البيع', '$salePrice SAR'),
          if (isAdmin) _buildRowDetail('التكلفة', '$costPrice SAR'),

          const Gap(10),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: onIncrement,
                  child: const Icon(Icons.add, size: 18, color: Colors.black87),
                ),
                CustomText(
                  text: '$quantity',
                  size: 14,
                  weight: FontWeight.bold,
                ),
                InkWell(
                  onTap: onDecrement,
                  child: const Icon(
                    Icons.remove,
                    size: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),

          SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: 'أضف للسلة',
              size: 13,
              onTap: onAddTOCart,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRowDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: value, weight: FontWeight.w600, size: 18),
          CustomText(text: label, color: Colors.grey.shade600, size: 18),
        ],
      ),
    );
  }
}
