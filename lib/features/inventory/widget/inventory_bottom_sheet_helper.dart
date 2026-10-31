// lib/features/inventory/presentation/helpers/inventory_bottom_sheet_helper.dart
import 'package:flutter/material.dart';
import 'package:inventory_managment/features/inventory/widget/add_stock_movement_buttom_sheet.dart';

class InventoryBottomSheetHelper {
  static void showAddMovement(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddStockMovementBottomSheet(),
    );
  }
}
