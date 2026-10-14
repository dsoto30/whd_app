import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Professional, minimalist theme for the internal IT helpdesk app.
/// Palette: black / white / turquoise, with the Open Sans typeface.
class AppColors {
  AppColors._();

  static const Color turquoise = Color(0xFF1ABC9C);
  static const Color turquoiseDark = Color(0xFF159C82);
  static const Color black = Color(0xFF121212);
  static const Color white = Color(0xFFFFFFFF);
  static const Color border = Color(0xFFE0E0E0);
  static const Color muted = Color(0xFF6B6B6B);
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: const ColorScheme.light(
        primary: AppColors.turquoise,
        onPrimary: AppColors.white,
        secondary: AppColors.turquoiseDark,
        onSecondary: AppColors.white,
        surface: AppColors.white,
        onSurface: AppColors.black,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.openSansTextTheme(base.textTheme).apply(
        bodyColor: AppColors.black,
        displayColor: AppColors.black,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        titleTextStyle: GoogleFonts.openSans(
          color: AppColors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.border),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.turquoise, width: 2),
        ),
        labelStyle: const TextStyle(color: AppColors.muted),
        prefixIconColor: AppColors.muted,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.turquoise,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.border,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: GoogleFonts.openSans(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.black,
        contentTextStyle: TextStyle(color: AppColors.white),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
