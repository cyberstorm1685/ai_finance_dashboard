import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/spacing.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Function(String) onChanged;
  final String? errorText;
  final String? initialValue;

  const CustomTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.onChanged,
    this.errorText,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kSpacingSmall),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: TextEditingController(text: initialValue),
              obscureText: obscureText,
              onChanged: onChanged,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(kSpacingMedium),
                errorText: errorText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}