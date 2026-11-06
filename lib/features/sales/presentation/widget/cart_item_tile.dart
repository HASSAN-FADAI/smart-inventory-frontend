import 'package:flutter/material.dart';
import 'package:inventory_managment/features/sales/domain/entities/order_entity.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class CartItemTile extends StatelessWidget {
  final CartItemEntity item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: IconButton(
        icon: const Icon(Icons.delete_outline, color: Colors.red),
        onPressed: onRemove,
      ),
      title: Align(
        alignment: Alignment.centerRight,
        child: CustomText(
          text: item.product.name,
          weight: FontWeight.bold,
          size: 15,
        ),
      ),
      subtitle: Align(
        alignment: Alignment.centerRight,
        child: CustomText(
          text:
              '${item.subTotal.toStringAsFixed(2)} SAR (${item.quantity} × ${item.product.price})',
          color: Colors.grey.shade700,
          size: 13,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 20),
            onPressed: onIncrement,
          ),
          CustomText(
            text: '${item.quantity}',
            weight: FontWeight.bold,
            size: 15,
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outline, size: 20),
            onPressed: onDecrement,
          ),
        ],
      ),
    );
  }
}
