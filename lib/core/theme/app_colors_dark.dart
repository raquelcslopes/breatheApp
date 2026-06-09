import 'package:flutter/material.dart';

/// Breathe — DARK palette.
/// Warm near-black canvas with cream text, beige actions, and earthy accents.
/// Designed to feel calm and premium on a black background.
class AppColorsDark {
  AppColorsDark._();

  // --- Surfaces (warm near-black) ---------------------------------------
  static const Color background = Color(0xFF0F0F0D); // warm black canvas
  static const Color surface = Color(0xFF1A1A16); // raised card
  static const Color surfaceAlt = Color(0xFF24241C); // recessed / tinted

  // --- Text -------------------------------------------------------------
  static const Color textPrimary = Color(0xFFF2EFE4); // warm white
  static const Color textSecondary = Color(0xFFC2BDAD);
  static const Color textMuted = Color(0xFF8C8A7C); // warm grey
  static const Color onAction = Color(0xFF161611); // dark text on beige
  static const Color onDark = Color(0xFFF2EFE4);

  // --- Brand / action (warm beige) --------------------------------------
  static const Color primary = Color(0xFFD8C29A); // beige — buttons / FAB
  static const Color primarySoft = Color(0xFFE7D9BC);

  // --- Green (structural) ----------------------------------------------
  static const Color forest = Color(0xFF9DB06A); // lifted olive
  static const Color forestDeep = Color(0xFF2A331C);

  // --- Browns / icons ---------------------------------------------------
  static const Color brownDark = Color(0xFFD8C29A); // beige — nav icons

  // --- Accents ----------------------------------------------------------
  static const Color sand = Color(0xFFD8C29A);
  static const Color slateBlue = Color(
    0xFF7E9085,
  ); // muted teal-green (cool note)
  static const Color clay = Color(0xFFC98A63); // warm terracotta
  static const Color plum = Color(0xFFB08C8E);

  // --- Mood (lifted to read on black) -----------------------------------
  static const Color moodGood = Color(0xFF9DB06A); // olive
  static const Color moodGoodBg = Color(0xFF1E2616);
  static const Color moodOkay = Color(0xFFD8C29A); // beige
  static const Color moodOkayBg = Color(0xFF2A2618);
  static const Color moodLow = Color(0xFFC98A63); // clay
  static const Color moodLowBg = Color(0xFF2A2016);

  // --- Feedback ---------------------------------------------------------
  static const Color danger = Color(0xFFE07A6E); // lifted coral-red

  // --- Lines ------------------------------------------------------------
  static const Color border = Color(0xFF2A2A22); // warm dark hairline
  static const Color borderSoft = Color(0x402A2A22);

  /// Gradient for the dark hero / check-in card.
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2A3319), Color(0xFF1A2010), Color(0xFF0C0C0A)],
    stops: [0.0, 0.55, 1.0],
  );

  // --- Appointments -----------------------------------------------------
  static const Color psychology = Color(0xFFD8C29A); // beige
  static const Color psychiatrist = Color(0xFF9DB06A); // olive
  static const Color gp = Color(0xFFC98A63); // clay
}
