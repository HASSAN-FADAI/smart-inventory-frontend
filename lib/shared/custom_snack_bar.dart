import 'package:flutter/material.dart';
import 'package:inventory_managment/core/errors/api_error.dart';
import 'package:inventory_managment/shared/custom_text.dart';

enum SnackBarType { success, error }

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required dynamic message,
    SnackBarType type = SnackBarType.error,
    Duration duration = const Duration(seconds: 4),
  }) {
    final String displayMessage = message is ApiError
        ? message.message
        : message.toString();

    final isSuccess = type == SnackBarType.success;

    final backgroundColor = isSuccess
        ? const Color(0xFF2E7D32)
        : const Color(0xFFD32F2F);
    final iconData = isSuccess
        ? Icons.check_circle_outline_rounded
        : Icons.error_outline_rounded;
    final titleText = isSuccess ? 'تمت العملية بنجاح' : 'حدث خطأ';

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        content: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(iconData, color: Colors.white, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: titleText,
                      weight: FontWeight.bold,
                      size: 14,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 2),
                    CustomText(
                      text: displayMessage,
                      size: 12,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
