import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Breathe — theme built on AppColors (earthy palette).
/// Fonts: Bricolage Grotesque (display & labels) + Hanken Grotesk (body/UI).
/// pubspec.yaml -> dependencies: google_fonts: ^6.2.1

class AppRadii {
  AppRadii._();
  static const card = 26.0;
  static const cardLarge = 20.0;
  static const button = 50.0;
  static const chip = 12.0;
  static const tile = 16.0;
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.forest, // burnt orange — actions, FAB
      onPrimary: AppColors.onAction,
      secondary: AppColors.primary, // olive — structural / nav active
      onSecondary: AppColors.onDark,
      tertiary: AppColors.sand,
      onTertiary: AppColors.textPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceAlt,
      outline: AppColors.border,
      outlineVariant: AppColors.borderSoft,
      error: AppColors.danger,
      onError: Colors.white,
    );

    final base = GoogleFonts.hankenGroteskTextTheme();
    TextStyle bric(
      double size,
      FontWeight w, {
      double height = 1.1,
      double spacing = 0,
      Color? color,
    }) => GoogleFonts.bricolageGrotesque(
      fontSize: size,
      fontWeight: w,
      height: height,
      letterSpacing: spacing,
      color: color ?? AppColors.textPrimary,
    );

    final textTheme = base.copyWith(
      displaySmall: bric(29, FontWeight.w700, height: 1.06, spacing: -0.6),
      headlineMedium: bric(25, FontWeight.w600, height: 1.12, spacing: -0.25),
      titleLarge: bric(19, FontWeight.w600, height: 1.15),
      labelLarge: bric(14, FontWeight.w600, spacing: 1.4),
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: 15,
        color: AppColors.textPrimary,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: 14,
        color: AppColors.textPrimary,
      ),
      bodySmall: base.bodySmall?.copyWith(
        fontSize: 12,
        color: AppColors.textMuted,
      ),
      titleMedium: base.bodyLarge?.copyWith(
        fontSize: 14,
        color: AppColors.slateBlue,
        fontWeight: FontWeight.bold,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: textTheme,
      splashFactory: InkRipple.splashFactory,
      iconTheme: const IconThemeData(color: AppColors.textSecondary, size: 22),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: bric(20, FontWeight.w700, spacing: -0.2),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),

      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
          side: const BorderSide(color: AppColors.border),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.forest,
          foregroundColor: AppColors.onAction,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          textStyle: GoogleFonts.hankenGrotesk(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.button),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.forest,
          textStyle: GoogleFonts.hankenGrotesk(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          side: const BorderSide(color: AppColors.border),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.button),
          ),
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.forest,
        foregroundColor: AppColors.onAction,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.tile)),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: GoogleFonts.hankenGrotesk(
          fontSize: 15,
          color: AppColors.textMuted,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.button),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.button),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.background,
        elevation: 0,
        height: 64,
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.all(
          GoogleFonts.bricolageGrotesque(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: AppColors.textMuted,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 23,
            color: states.contains(WidgetState.selected)
                ? AppColors.forest
                : AppColors.textMuted,
          ),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: Color.fromARGB(75, 94, 112, 102),
        thickness: 1,
        space: 1,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        side: const BorderSide(color: AppColors.borderSoft),
        labelStyle: GoogleFonts.hankenGrotesk(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.forest,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.surface,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        insetPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
