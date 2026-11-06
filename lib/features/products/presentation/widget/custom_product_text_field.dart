import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class CustomProductTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isNumber;
  final int maxLines;

  const CustomProductTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isNumber = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomText(text: label, size: 14, weight: FontWeight.w600),
        const Gap(6),
        TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          maxLines: maxLines,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ],
    );
  }
}
