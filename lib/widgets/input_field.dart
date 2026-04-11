import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool obscure;
  final bool hasSuffix;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  static const Color textDark = Color(0xFF222222);
  static const Color textLight = Color(0xFF9A9A9A);
  static const Color borderColor = Color(0xFFE5E5E5);
  static const Color orangeButton = Color(0xFFFF5A1F);

  const InputField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.hasSuffix = false,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: textDark,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: textLight,
              fontSize: 12,
            ),
            prefixIcon: Icon(
              icon,
              size: 18,
              color: textLight,
            ),
            suffixIcon: hasSuffix
                ? const Icon(
                    Icons.keyboard_arrow_down,
                    color: textLight,
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: orangeButton,
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}