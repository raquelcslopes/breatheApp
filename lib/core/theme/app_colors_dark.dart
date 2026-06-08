import 'package:flutter/material.dart';

/// Breathe — DARK palette.
/// Dark brown background (#553922 family); action = lighter green of the palette.
class AppColorsDark {
  AppColorsDark._();

  // --- Surfaces (dark brown base, not black) ----------------------------
  static const Color background = Color(0xFF2A1E12); // deep brown coffee
  static const Color surface = Color(0xFF3A2C1D); // raised card
  static const Color surfaceAlt = Color(0xFF453524); // recessed / tinted

  // --- Text -------------------------------------------------------------
  static const Color textPrimary = Color(0xFFF1ECDA); // warm cream
  static const Color textSecondary = Color(0xFFCDBEA1);
  static const Color textMuted = Color(0xFF9A8A6E);
  static const Color onAction = Color(0xFF20180F); // dark text on light green
  static const Color onDark = Color(0xFFF1ECDA);

  // --- Brand / action (lighter olive/green) -----------------------------
  static const Color primary = Color(
    0xFF8FA15A,
  ); // lifted olive — buttons / FAB
  static const Color primarySoft = Color(0xFFAEBD82);

  // --- Green (structural) ----------------------------------------------
  static const Color forest = Color(0xFF8FA15A);
  static const Color forestDeep = Color(0xFF3A4A26);

  // --- Browns ----------------------------------------------------------
  static const Color brownDark = Color(
    0xFFC79A6A,
  ); // lifted brown — nav icons on dark

  // --- Accents ----------------------------------------------------------
  static const Color sand = Color(0xFFC79A6A);
  static const Color slateBlue = Color(0xFF7E9085);
  static const Color clay = Color(0xFFB07C4E);
  static const Color plum = Color(0xFF9A7A5A);

  // --- Mood (lifted to read on dark) ------------------------------------
  static const Color moodGood = Color(0xFF8FA15A);
  static const Color moodGoodBg = Color(0xFF3A4226);
  static const Color moodOkay = Color(0xFFC79A6A);
  static const Color moodOkayBg = Color(0xFF45351F);
  static const Color moodLow = Color(0xFFB07C4E);
  static const Color moodLowBg = Color(0xFF3F2F1E);

  // --- Feedback ---------------------------------------------------------
  static const Color danger = Color(0xFFD66A60);

  // --- Lines ------------------------------------------------------------
  static const Color border = Color(0xFF4E3D2A);
  static const Color borderSoft = Color(0x404E3D2A);

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4A3A24), Color(0xFF3A4A26), Color(0xFF241B10)],
    stops: [0.0, 0.5, 1.0],
  );

  // --- Appointments -----------------------------------------------------
  static const Color psychology = Color(0xFFC79A6A);
  static const Color psychiatrist = Color(0xFF8FA15A);
  static const Color gp = Color(0xFFB8916A);
}
