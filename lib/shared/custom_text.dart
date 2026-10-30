import 'package:flutter/material.dart';
import 'package:inventory_managment/core/constants/app_font.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.weight,
  });
  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textScaler: TextScaler.linear(1.0),
      style: AppFonts.vazirmatn(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }
}
