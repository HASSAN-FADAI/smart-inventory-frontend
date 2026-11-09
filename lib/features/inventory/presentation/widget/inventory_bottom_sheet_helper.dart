import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_managment/features/inventory/presentation/cubit/inventory_cubit.dart';
import 'package:inventory_managment/features/inventory/presentation/widget/add_stock_movement_buttom_sheet.dart';

class InventoryBottomSheetHelper {
  static void showAddMovement(BuildContext context) {
    final cubit = context.read<InventoryCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: AddStockMovementBottomSheet(products: cubit.productsList),
      ),
    );
  }
}
