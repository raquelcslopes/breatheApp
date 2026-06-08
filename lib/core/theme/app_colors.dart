import 'package:flutter/material.dart';

/// Breathe — LIGHT palette.
/// Base: #283618 deep green · #606C38 olive · #FEFAE0 cornsilk
///       #875C35 tan (action) · #553922 dark brown (nav icons)
/// Background = soft greenish-white (#EBEFE3).
class AppColors {
  AppColors._();

  // --- Surfaces ---------------------------------------------------------
  static const Color background = Color(0xFFEBEFE3); // greenish-white canvas
  static const Color surface = Color(0xFFFFFFFF); // cards
  static const Color surfaceAlt = Color(0xFFF2F5EB); // recessed / tinted

  // --- Text -------------------------------------------------------------
  static const Color textPrimary = Color(0xFF283618); // deep green
  static const Color textSecondary = Color(0xFF5C6347);
  static const Color textMuted = Color(0xFF8A9079);
  static const Color onAction = Color(0xFFFEFAE0); // cream text on tan
  static const Color onDark = Color(0xFFFEFAE0);

  // --- Brand / action ---------------------------------------------------
  static const Color primary = Color(
    0xFF875C35,
  ); // tan — buttons / FAB / action
  static const Color primarySoft = Color(0xFFA9794D);

  // --- Green (structural) ----------------------------------------------
  static const Color forest = Color(0xFF606C38); // olive — secondary
  static const Color forestDeep = Color(0xFF283618);

  // --- Browns ----------------------------------------------------------
  static const Color brownDark = Color(0xFF553922); // dark brown — nav icons

  // --- Accents ----------------------------------------------------------
  static const Color sand = Color(0xFFA9794D);
  static const Color slateBlue = Color(0xFF5E7066);
  static const Color clay = Color(0xFF875C35);
  static const Color plum = Color(0xFF553922);

  // --- Mood scale (good -> okay -> low) ---------------------------------
  static const Color moodGood = forest;
  static const Color moodGoodBg = Color(0xFFE6EAD5);

  static const Color moodOkay = Color.fromARGB(255, 221, 208, 94);
  static const Color moodOkayBg = Color(0xFFFBF1D9);

  static const Color moodLow = Color(0xFFBC6C25);
  static const Color moodLowBg = Color(0xFFF6E6D5);

  // --- Feedback ---------------------------------------------------------
  static const Color danger = Color(0xFFA8362F);

  // --- Lines ------------------------------------------------------------
  static const Color border = Color(0xFFDBE1CD); // soft sage hairline
  static const Color borderSoft = Color(0xFFE3E8D8);

  /// Gradient for the dark hero / check-in card.
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF606C38), Color(0xFF3D4D26), Color(0xFF283618)],
    stops: [0.0, 0.5, 1.0],
  );

  // --- Appointments -----------------------------------------------------
  static const Color psychology = Color(0xFF875C35); // tan
  static const Color psychiatrist = Color(0xFF606C38); // olive
  static const Color gp = Color(0xFF553922); // dark brown
}
