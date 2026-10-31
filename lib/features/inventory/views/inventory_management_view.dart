import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/features/dashboard/widget/search_field.dart';
import 'package:inventory_managment/features/inventory/widget/inventory_app_bar.dart';
import 'package:inventory_managment/features/inventory/widget/inventory_bottom_sheet_helper.dart';
import 'package:inventory_managment/features/inventory/widget/inventory_header_section.dart';
import 'package:inventory_managment/features/inventory/widget/inventory_movements_list_section.dart';
import 'package:inventory_managment/features/inventory/widget/inventory_state_row.dart';
import 'package:inventory_managment/features/inventory/widget/inventory_type_filter.dart';
import 'package:inventory_managment/shared/Custom_drawer.dart';

class InventoryManagementView extends StatefulWidget {
  const InventoryManagementView({super.key});

  @override
  State<InventoryManagementView> createState() =>
      _InventoryManagementViewState();
}

class _InventoryManagementViewState extends State<InventoryManagementView> {
  String selectedFilter = 'ALL';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldPrimary,
      endDrawer: const CustomDrawer(),
      appBar: const InventoryAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InventoryHeaderSection(),
            Gap(15),
            SearchField(),
            Gap(15),
            InventoryTypeFilter(
              onSelected: (type) {
                setState(() => selectedFilter = type);
              },
            ),
            Gap(20),
            InventoryStatsRow(),
            Gap(25),
            InventoryMovementsListSection(selectedFilter: selectedFilter),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => InventoryBottomSheetHelper.showAddMovement(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
