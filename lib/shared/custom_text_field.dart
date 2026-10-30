import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_managment/core/constants/app_color.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.isPassword,
    required this.controller,
    required this.icon,
    required this.prefixColor,
  });
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final Icon icon;
  final Color prefixColor;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText = widget.isPassword;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'إملء من فضلك ${widget.hintText}';
        }

        return null;
      },
      controller: widget.controller,
      obscureText: _obscureText,
      cursorHeight: 17,
      cursorColor: AppColors.primary,

      decoration: InputDecoration(
        prefixIcon: widget.icon,
        prefixIconColor: widget.prefixColor,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(CupertinoIcons.eye),
              )
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),

        hintText: widget.hintText,
      ),
    );
  }
}
