// lib/features/dashboard/widget/custom_card.dart
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inventory_managment/core/constants/app_color.dart';
import 'package:inventory_managment/shared/custom_text.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.backgroundIconColor,
    required this.iconColor,
  });

  final String title;
  final String value;
  final String subtitle;
  final Icon icon;
  final Color backgroundIconColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: AppColors.secondry,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // العنوان والأيقونة
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: backgroundIconColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: icon),
                  ),
                  CustomText(text: title, weight: FontWeight.bold, size: 15),
                ],
              ),
              const Gap(15),
              // القيمة الكبرى (مثل الرقم أو المبلغ)
              CustomText(text: value, weight: FontWeight.bold, size: 22),
              const Gap(10),
              // الوصف السفلي
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    text: subtitle,
                    size: 13,
                    weight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                  const Gap(6),
                  CircleAvatar(backgroundColor: iconColor, radius: 4),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
