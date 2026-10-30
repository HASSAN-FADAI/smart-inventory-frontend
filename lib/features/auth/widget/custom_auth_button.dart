import 'package:flutter/material.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    this.onTap,
    this.color,
    this.textColor,
    this.widget,
    required this.text,
  });
  final Function()? onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: CustomText(
            text: text,
            color: textColor ?? AppColors.textPrimary,
            size: 17,
            weight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
