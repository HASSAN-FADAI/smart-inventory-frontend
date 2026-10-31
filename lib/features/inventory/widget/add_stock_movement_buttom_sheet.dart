import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/shared/custom_button.dart';
import 'package:inventory_managment/shared/custom_text.dart';
import 'package:inventory_managment/shared/custom_text_field.dart';

class AddStockMovementBottomSheet extends StatefulWidget {
  const AddStockMovementBottomSheet({super.key});

  @override
  State<AddStockMovementBottomSheet> createState() =>
      _AddStockMovementBottomSheetState();
}

class _AddStockMovementBottomSheetState
    extends State<AddStockMovementBottomSheet> {
  final _qtyController = TextEditingController();
  final _reasonController = TextEditingController();
  String selectedType = 'IN';

  @override
  void dispose() {
    _qtyController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Center(
            child: CustomText(
              text: 'تسجيل حركة مخزن جديدة',
              size: 18,
              weight: FontWeight.bold,
            ),
          ),
          const Gap(20),
          const CustomText(
            text: 'نوع الحركة',
            size: 14,
            weight: FontWeight.w600,
          ),
          const Gap(8),
          _buildTypeDropdown(),
          const Gap(15),
          CustomTextField(
            hintText: 'الكمية',
            isPassword: false,
            controller: _qtyController,
            icon: const Icon(Icons.numbers),
            prefixColor: AppColors.primary,
          ),
          const Gap(15),
          CustomTextField(
            hintText: 'سبب الحركة / الملاحظات (اختياري)',
            isPassword: false,
            controller: _reasonController,
            icon: const Icon(Icons.notes),
            prefixColor: AppColors.primary,
          ),
          const Gap(25),
          Center(
            child: CustomButton(
              text: 'حفظ الحركة',
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: selectedType,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
      items: const [
        DropdownMenuItem(
          value: 'IN',
          child: Align(
            alignment: Alignment.centerRight,
            child: Text('وارد (IN)'),
          ),
        ),
        DropdownMenuItem(
          value: 'OUT',
          child: Align(
            alignment: Alignment.centerRight,
            child: Text('صادر (OUT)'),
          ),
        ),
        DropdownMenuItem(
          value: 'ADJUSTMENT',
          child: Align(
            alignment: Alignment.centerRight,
            child: Text('تعديل / جرد (ADJUSTMENT)'),
          ),
        ),
      ],
      onChanged: (val) => setState(() => selectedType = val!),
    );
  }
}
