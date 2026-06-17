import 'package:flutter/material.dart';

/// Light counterpart to [AppColors], derived from the SERENITY light theme.
/// Same field names so it drops into the theme in parallel with the dark set.
abstract final class AppColorsLight {
  // Backgrounds
  static const background = Color(0xFFF9F8F4);

  static const surface = Color(0xFFF4F3ED);
  static const surfaceDim = Color(0xFFF2F1E9);

  static const surfaceContainerLowest = Color(0xFFFFFFFF);
  static const surfaceContainerLow = Color(0xFFF6F4EC);
  static const surfaceContainer = Color(0xFFF0EFE7);
  static const surfaceContainerHigh = Color(0xFFF0EFE7);
  static const surfaceContainerHighest = Color(0xFFE4E3DB);

  static const surfaceBright = Color(0xFFFFFFFF);

  // Primary
  static const primary = Color(0xFF5A614D);
  static const primaryContainer = Color(0xFFDEE5C8);

  static const primaryFixed = Color(0xFFDFE5CC);
  static const primaryFixedDim = Color(0xFFC3C9B1);

  static const onPrimary = Color(0xFFFFFFFF);
  static const onPrimaryContainer = Color(0xFF424937);

  // Secondary
  static const secondary = Color(0xFF5D5C54);
  static const secondaryContainer = Color(0xFFE3E1D3);

  static const onSecondary = Color(0xFFFFFFFF);
  static const onSecondaryContainer = Color(0xFF454539);

  // Tertiary
  static const tertiary = Color(0xFF44492E);
  static const tertiaryContainer = Color(0xFFC5CAA6);

  static const onTertiary = Color(0xFFFFFFFF);
  static const onTertiaryContainer = Color(0xFF2E331A);

  // Text
  static const textPrimary = Color(0xFF1B1C16);
  static const textSecondary = Color(0xFF46483C);
  static const textMuted = Color(0xFF777A6C);

  // Borders
  static const outline = Color(0xFF777A6C);
  static const outlineVariant = Color(0xFFC7C8B8);

  // States
  static const error = Color(0xFFBA1A1A);
  static const errorContainer = Color(0xFFFFDAD6);

  // Extras
  static const inverseSurface = Color(0xFF303128);
  static const inversePrimary = Color(0xFFC3C9B1);

  static const shadow = Color(0x26302826);
}
