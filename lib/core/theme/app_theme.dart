import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_colors_dark.dart';

/// Fonts: Bricolage Grotesque (display & labels) + Hanken Grotesk (body/UI).

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

  static ThemeData get light => _build(
    brightness: Brightness.light,
    background: AppColors.background,
    surface: AppColors.surface,
    surfaceAlt: AppColors.surfaceAlt,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    textMuted: AppColors.textMuted,
    onAction: AppColors.onAction,
    onDark: AppColors.onDark,
    action: AppColors.primary, // tan — buttons
    secondary: AppColors.forest, // olive
    navIcon: AppColors.brownDark, // dark brown — nav icons
    sand: AppColors.sand,
    border: AppColors.border,
    borderSoft: AppColors.borderSoft,
    danger: AppColors.danger,
  );

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    background: AppColorsDark.background,
    surface: AppColorsDark.surface,
    surfaceAlt: AppColorsDark.surfaceAlt,
    textPrimary: AppColorsDark.textPrimary,
    textSecondary: AppColorsDark.textSecondary,
    textMuted: AppColorsDark.textMuted,
    onAction: AppColorsDark.onAction,
    onDark: AppColorsDark.onDark,
    action: AppColorsDark.primary, // light green — buttons
    secondary: AppColorsDark.forest,
    navIcon: AppColorsDark.textPrimary, // lifted brown — nav icons
    sand: AppColorsDark.sand,
    border: AppColorsDark.border,
    borderSoft: AppColorsDark.borderSoft,
    danger: AppColorsDark.danger,
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color surface,
    required Color surfaceAlt,
    required Color textPrimary,
    required Color textSecondary,
    required Color textMuted,
    required Color onAction,
    required Color onDark,
    required Color action,
    required Color secondary,
    required Color navIcon,
    required Color sand,
    required Color border,
    required Color borderSoft,
    required Color danger,
  }) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: action,
      onPrimary: onAction,
      secondary: secondary,
      onSecondary: onDark,
      tertiary: sand,
      onTertiary: background,
      surface: surface,
      onSurface: textPrimary,
      surfaceContainerHighest: surfaceAlt,
      outline: border,
      outlineVariant: textMuted,
      error: danger,
      onError: brightness == Brightness.dark ? background : Colors.white,
    );

    final base = GoogleFonts.hankenGroteskTextTheme(
      brightness == Brightness.dark
          ? ThemeData(brightness: Brightness.dark).textTheme
          : null,
    );

    TextStyle bric(
      double size,
      FontWeight w, {
      double height = 1.1,
      double spacing = 0,
      Color? color,
    }) => GoogleFonts.manrope(
      fontSize: size,
      fontWeight: w,
      height: height,
      letterSpacing: spacing,
      color: color ?? textPrimary,
    );

    final textTheme = base.copyWith(
      displaySmall: bric(29, FontWeight.w700, height: 1.06, spacing: -0.6),
      headlineMedium: bric(25, FontWeight.w600, height: 1.12, spacing: -0.25),
      titleLarge: bric(19, FontWeight.w600, height: 1.15),
      labelLarge: bric(14, FontWeight.w600, spacing: 1.4),
      bodyLarge: base.bodyLarge?.copyWith(fontSize: 15, color: textPrimary),
      bodyMedium: base.bodyMedium?.copyWith(fontSize: 14, color: textPrimary),
      bodySmall: base.bodySmall?.copyWith(fontSize: 12, color: textMuted),
      titleMedium: base.bodyLarge?.copyWith(
        fontSize: 14,
        color: textMuted,
        fontWeight: FontWeight.bold,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      textTheme: textTheme,
      splashFactory: InkRipple.splashFactory,
      iconTheme: IconThemeData(color: textSecondary, size: 22),

      appBarTheme: AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: bric(20, FontWeight.w700, spacing: -0.2),
        iconTheme: IconThemeData(color: textPrimary),
      ),

      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: action,
          foregroundColor: onAction,
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
          foregroundColor: action,
          textStyle: GoogleFonts.hankenGrotesk(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return textMuted.withAlpha(40);
            }
            return textMuted;
          }),
          iconColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return textMuted.withAlpha(40);
            }
            return textMuted;
          }),
          side: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return BorderSide(color: border.withAlpha(40));
            }
            return BorderSide(color: border);
          }),
          padding: WidgetStatePropertyAll(
            const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.button),
            ),
          ),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: action,
        foregroundColor: onAction,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadii.tile)),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        hintStyle: GoogleFonts.hankenGrotesk(fontSize: 15, color: textMuted),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.button),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.button),
          borderSide: BorderSide(color: border),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: background,
        elevation: 0,
        height: 64,
        indicatorColor: Colors.transparent,
        labelTextStyle: WidgetStateProperty.all(
          GoogleFonts.bricolageGrotesque(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: textMuted,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            size: 23,
            // active = dark brown (nav icons); inactive = muted
            color: states.contains(WidgetState.selected) ? navIcon : textMuted,
          ),
        ),
      ),

      dividerTheme: DividerThemeData(color: borderSoft, thickness: 1, space: 1),

      chipTheme: ChipThemeData(
        backgroundColor: surface,
        side: BorderSide(color: borderSoft),
        labelStyle: GoogleFonts.hankenGrotesk(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: textSecondary,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: action,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: onAction),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        insetPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
