import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_managment/core/services/locator.dart';
import 'package:inventory_managment/features/inventory/presentation/cubit/inventory_cubit.dart';
import 'package:inventory_managment/features/inventory/presentation/widget/inventory_view_body.dart';

class InventoryManagementView extends StatelessWidget {
  const InventoryManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<InventoryCubit>()..fetchInventoryData(),
      child: const InventoryViewBody(),
    );
  }
}
