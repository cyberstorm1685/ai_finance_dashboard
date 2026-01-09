import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';

class AppTheme {
  static ThemeData light() => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.surfaceLight,
    textTheme: GoogleFonts.poppinsTextTheme(),
     );

  static ThemeData dark() => ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.surfaceDark,
    textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.white),
  );
}