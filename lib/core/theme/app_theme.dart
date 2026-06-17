import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_colors_light.dart';

abstract final class AppTheme {
  static ThemeData light() {
    final scheme = ColorScheme.light(
      brightness: Brightness.light,

      primary: AppColorsLight.primary,
      onPrimary: AppColorsLight.onPrimary,
      primaryContainer: AppColorsLight.primaryContainer,
      onPrimaryContainer: AppColorsLight.onPrimaryContainer,

      secondary: AppColorsLight.secondary,
      onSecondary: AppColorsLight.onSecondary,

      tertiary: AppColorsLight.tertiary,
      onTertiary: AppColorsLight.onTertiary,

      error: AppColorsLight.error,
      errorContainer: AppColorsLight.errorContainer,

      surface: AppColorsLight.surface,
      onSurface: AppColorsLight.textPrimary,
      surfaceContainer: AppColorsLight.surfaceContainer,
      surfaceDim: AppColorsLight.textMuted,
      surfaceContainerHighest: AppColorsLight.surfaceContainerHighest,

      outline: AppColorsLight.outline,
      outlineVariant: AppColorsLight.outlineVariant,

      inversePrimary: AppColorsLight.inversePrimary,
      inverseSurface: AppColorsLight.inverseSurface,
    );

    return ThemeData(
      useMaterial3: true,

      colorScheme: scheme,

      scaffoldBackgroundColor: AppColorsLight.background,

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),

      cardTheme: CardThemeData(
        color: AppColorsLight.surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColorsLight.outlineVariant,
        thickness: 1,
      ),

      iconTheme: const IconThemeData(color: AppColorsLight.textPrimary),

      textTheme: TextTheme(
        headlineLarge: GoogleFonts.bodoniModa(
          fontSize: 38,
          fontWeight: FontWeight.w500,
          color: AppColorsLight.textPrimary,
          height: 1.1,
        ),

        headlineMedium: GoogleFonts.bodoniModa(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: AppColorsLight.textPrimary,
        ),

        headlineSmall: GoogleFonts.bodoniModa(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: AppColorsLight.textPrimary,
        ),

        titleMedium: GoogleFonts.hankenGrotesk(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 2.4,
          color: AppColorsLight.textPrimary,
        ),

        bodyLarge: GoogleFonts.hankenGrotesk(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColorsLight.textPrimary,
          height: 1.6,
        ),

        bodyMedium: GoogleFonts.hankenGrotesk(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColorsLight.textPrimary,
          height: 1.5,
        ),

        labelMedium: GoogleFonts.hankenGrotesk(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 3,
          color: AppColorsLight.primary,
        ),

        bodySmall: GoogleFonts.hankenGrotesk(
          fontSize: 12,
          color: AppColorsLight.primary,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColorsLight.primary,
          foregroundColor: AppColorsLight.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          shape: const StadiumBorder(),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColorsLight.primary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          shape: const StadiumBorder(),
          side: BorderSide(color: AppColorsLight.primary),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColorsLight.primary,
          foregroundColor: AppColorsLight.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          shape: const StadiumBorder(),
          shadowColor: AppColorsLight.primary.withAlpha(80),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColorsLight.primary,
        foregroundColor: AppColorsLight.onPrimary,
        shape: CircleBorder(),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColorsLight.primary),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColorsLight.surfaceContainerHigh,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColorsLight.onPrimary;
          }
          return AppColorsLight.textMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColorsLight.primary;
          }
          return AppColorsLight.surfaceContainer;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.transparent;
          }
          return AppColorsLight.outline;
        }),
      ),
    );
  }

  static ThemeData dark() {
    final scheme = ColorScheme.dark(
      brightness: Brightness.dark,
      surfaceTint: Colors.transparent,

      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      onPrimaryContainer: AppColors.primary,
      primaryFixedDim: AppColors.primaryFixedDim,

      secondary: AppColors.secondary,
      onSecondary: AppColors.onSecondary,

      tertiary: AppColors.tertiary,
      onTertiary: AppColors.onTertiary,
      tertiaryFixed: AppColors.textSecondary,

      error: AppColors.errorContainer,

      surface: AppColors.surface,
      surfaceContainer: AppColors.surfaceContainer,
      onSurface: AppColors.textPrimary,
      surfaceDim: AppColors.textMuted,
      inversePrimary: AppColors.primary,
      surfaceContainerHighest: AppColors.textMuted,

      outline: AppColors.outline,
      outlineVariant: AppColors.outlineVariant,

      errorContainer: AppColors.error,
    );

    return ThemeData(
      useMaterial3: true,

      colorScheme: scheme,

      scaffoldBackgroundColor: AppColors.background,

      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),

      cardTheme: CardThemeData(
        color: AppColors.surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.outlineVariant,
        thickness: 1,
      ),

      iconTheme: const IconThemeData(color: AppColors.primary),

      textTheme: TextTheme(
        headlineLarge: GoogleFonts.bodoniModa(
          fontSize: 38,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          height: 1.1,
        ),

        headlineMedium: GoogleFonts.bodoniModa(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),

        headlineSmall: GoogleFonts.bodoniModa(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),

        titleMedium: GoogleFonts.hankenGrotesk(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 2.4,
          color: AppColors.textPrimary,
        ),

        bodyLarge: GoogleFonts.hankenGrotesk(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
          height: 1.6,
        ),

        bodyMedium: GoogleFonts.hankenGrotesk(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
          height: 1.5,
        ),

        labelMedium: GoogleFonts.hankenGrotesk(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 3,
          color: AppColors.primary,
        ),

        bodySmall: GoogleFonts.hankenGrotesk(
          fontSize: 12,
          color: AppColors.primary,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          shape: const StadiumBorder(),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          shape: const StadiumBorder(),
          side: BorderSide(color: AppColors.primary),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          shape: const StadiumBorder(),
          shadowColor: AppColors.primary.withAlpha(120),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        shape: CircleBorder(),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primary),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceContainer.withValues(alpha: 0.4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),

      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.onPrimary;
          }
          return AppColors.textMuted;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.surfaceContainer;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.transparent;
          }
          return AppColors.outline;
        }),
      ),
    );
  }
}
