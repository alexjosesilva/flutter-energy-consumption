import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool obscure;
  final bool hasSuffix;
  final TextEditingController? controller;

  const InputField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.hasSuffix = false,
    this.controller,
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
            color: LoginScreen.textDark,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: LoginScreen.textLight,
              fontSize: 12,
            ),
            prefixIcon: Icon(
              icon,
              size: 18,
              color: LoginScreen.textLight,
            ),
            suffixIcon: hasSuffix
                ? const Icon(
                    Icons.keyboard_arrow_down,
                    color: LoginScreen.textLight,
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
              borderSide: const BorderSide(color: LoginScreen.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: LoginScreen.orangeButton,
                width: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}