import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const double pillRadius = 50;

  static const double cardRadius = 20;

  static ThemeData get light {
    final colorScheme =
        ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.primary,
          onPrimary: AppColors.onAction,
          surface: AppColors.surface,
          onSurface: AppColors.textPrimary,
          error: AppColors.danger,
        );

    final displayFont = GoogleFonts.aboreto;
    final bodyFont = GoogleFonts.andadaPro;

    final baseTextTheme = ThemeData.light().textTheme;

    final textTheme = TextTheme(
      displayLarge: displayFont(
        textStyle: baseTextTheme.displayLarge,
        fontSize: 32,
        letterSpacing: 4,
        color: AppColors.textPrimary,
      ),
      headlineLarge: displayFont(
        textStyle: baseTextTheme.headlineLarge,
        fontSize: 24,
        letterSpacing: 2.5,
        color: AppColors.textPrimary,
      ),
      headlineMedium: displayFont(
        textStyle: baseTextTheme.headlineMedium,
        fontSize: 20,
        letterSpacing: 2,
        color: AppColors.textPrimary,
      ),
      titleLarge: bodyFont(
        textStyle: baseTextTheme.titleLarge,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      titleMedium: bodyFont(
        textStyle: baseTextTheme.titleMedium,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
      bodyLarge: bodyFont(
        textStyle: baseTextTheme.bodyLarge,
        fontSize: 15,
        height: 1.6,
        color: AppColors.textPrimary,
      ),
      bodyMedium: bodyFont(
        textStyle: baseTextTheme.bodyMedium,
        fontSize: 14,
        height: 1.5,
        color: AppColors.textPrimary,
      ),
      bodySmall: bodyFont(
        textStyle: baseTextTheme.bodySmall,
        fontSize: 12,
        color: AppColors.textSecondary,
      ),
      labelLarge: bodyFont(
        textStyle: baseTextTheme.labelLarge,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: textTheme,

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onAction,
          textStyle: textTheme.labelLarge,
          minimumSize: const Size.fromHeight(54),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(pillRadius),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          minimumSize: const Size.fromHeight(54),
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(pillRadius),
          ),
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cardRadius),
          side: const BorderSide(color: AppColors.border, width: 0.5),
        ),
        margin: EdgeInsets.zero,
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: AppColors.border, width: 0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: AppColors.border, width: 0.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.onAction
              : AppColors.surface,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? AppColors.primary
              : const Color(0xFFD8CFBF),
        ),
        trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineMedium,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        selectedColor: const Color(0xFFE7EEE9),
        side: const BorderSide(color: AppColors.border, width: 1),
        labelStyle: textTheme.bodySmall?.copyWith(color: AppColors.textPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
