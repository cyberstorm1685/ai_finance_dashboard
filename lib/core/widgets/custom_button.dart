import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/spacing.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isGoogle;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isGoogle = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.all(kSpacingMedium),
        decoration: BoxDecoration(
          color: isGoogle ? Colors.white : AppColors.primary,
          borderRadius: BorderRadius.circular(12),
          border: isGoogle ? Border.all(color: AppColors.primary) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: isGoogle ? AppColors.primary : Colors.white),
              const SizedBox(width: 12),
            ],
            Text(
              text,
              style: TextStyle(
                color: isGoogle ? AppColors.primary : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}