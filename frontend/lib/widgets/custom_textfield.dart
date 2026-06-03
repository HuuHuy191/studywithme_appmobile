import 'package:flutter/material.dart';

import '../core/constants/app_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;

  final String hint;

  final bool obscureText;

  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      obscureText: obscureText,

      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,

        filled: true,

        fillColor: AppColors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),

          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(color: Colors.red),
      ),
    );
  }
}