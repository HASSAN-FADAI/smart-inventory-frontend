import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/dashboard/presentation/widget/search_field.dart';
import 'package:inventory_managment/features/inventory/presentation/cubit/inventory_cubit.dart';
import 'package:inventory_managment/features/inventory/presentation/cubit/inventory_state.dart';
import 'package:inventory_managment/features/inventory/presentation/widget/inventory_app_bar.dart';
import 'package:inventory_managment/features/inventory/presentation/widget/inventory_bottom_sheet_helper.dart';
import 'package:inventory_managment/features/inventory/presentation/widget/inventory_header_section.dart';
import 'package:inventory_managment/features/inventory/presentation/widget/inventory_movements_list_section.dart';
import 'package:inventory_managment/features/inventory/presentation/widget/inventory_state_row.dart';
import 'package:inventory_managment/features/inventory/presentation/widget/inventory_type_filter.dart';
import 'package:inventory_managment/shared/Custom_drawer.dart';

class InventoryViewBody extends StatefulWidget {
  const InventoryViewBody({super.key});

  @override
  State<InventoryViewBody> createState() => _InventoryViewBodyState();
}

class _InventoryViewBodyState extends State<InventoryViewBody> {
  String selectedFilter = 'ALL';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldPrimary,
      endDrawer: const CustomDrawer(),
      appBar: const InventoryAppBar(),
      body: BlocBuilder<InventoryCubit, InventoryState>(
        builder: (context, state) {
          if (state is InventoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is InventoryErrorState) {
            return Center(child: Text(state.message));
          }
          if (state is InventoryLoadedState) {
            final totalIn = state.transactions
                .where((t) => t.type == 'IN')
                .fold(0, (sum, t) => sum + t.quantity);
            final totalOut = state.transactions
                .where((t) => t.type == 'OUT')
                .fold(0, (sum, t) => sum + t.quantity);

            final filteredMovements = selectedFilter == 'ALL'
                ? state.transactions
                : state.transactions
                      .where((t) => t.type == selectedFilter)
                      .toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const InventoryHeaderSection(),
                  const Gap(15),
                  const SearchField(),
                  const Gap(15),
                  InventoryTypeFilter(
                    onSelected: (type) => setState(() => selectedFilter = type),
                  ),
                  const Gap(20),
                  InventoryStatsRow(totalIn: totalIn, totalOut: totalOut),
                  const Gap(25),
                  InventoryMovementsListSection(
                    selectedFilter: selectedFilter,
                    movements: filteredMovements,
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: Builder(
        builder: (btnContext) => FloatingActionButton(
          backgroundColor: AppColors.primary,
          onPressed: () =>
              InventoryBottomSheetHelper.showAddMovement(btnContext),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
