import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    this.color,
    this.textColor,
    this.widget,
    required this.text,
    this.icon,
    this.size,
  });
  final Function()? onTap;
  final String text;
  final Color? color;
  final Color? textColor;
  final Widget? widget;
  final Icon? icon;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 196,
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: text,
              color: textColor ?? AppColors.textSecondry,
              weight: FontWeight.bold,
              size: size,
            ),
            Gap(9),
            Center(child: icon),
          ],
        ),
      ),
    );
  }
}
