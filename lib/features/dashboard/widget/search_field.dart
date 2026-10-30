import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_managment/core/constants/app_color.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, this.onChanged});
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorHeight: 20,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        prefixIcon: const Icon(CupertinoIcons.search, color: Colors.grey),
        hintText: ' SKU/البحث عن منتج',
        hintStyle: TextStyle(color: Colors.grey.shade600),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
      ),
    );
  }
}
