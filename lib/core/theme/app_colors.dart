import 'package:flutter/material.dart';

/// Breathe — colour palette.
/// Built on the earthy 5-colour set:
///   #606C38 olive · #283618 deep green · #FEFAE0 cornsilk
///   #DDA15E earth yellow · #BC6C25 tiger's eye (burnt orange)
class AppColors {
  AppColors._();

  // --- Surfaces ---------------------------------------------------------
  static const Color background = Color(0xFFFEFAE0); // cornsilk canvas
  static const Color surface = Color(0xFFFFFFFF); // cards
  static const Color surfaceAlt = Color(0xFFF6EFD7); // recessed / tinted cards

  // --- Text -------------------------------------------------------------
  static const Color textPrimary = Color(0xFF283618); // deep green (near-black)
  static const Color textSecondary = Color(0xFF5C6347);
  static const Color textMuted = Color(0xFF8E9079); // placeholders / tertiary
  static const Color onAction = Color(0xFFFFFFFF); // text on burnt orange
  static const Color onDark = Color(0xFFFEFAE0); // text on dark-green hero

  // --- Brand / action ---------------------------------------------------
  static const Color primary = Color(0xFFBC6C25); // tiger's eye — main action
  static const Color primarySoft = Color(0xFFDDA15E); // earth yellow

  // --- Green (structural) ----------------------------------------------
  static const Color forest = Color(0xFF606C38); // olive — secondary / nav
  static const Color forestDeep = Color(0xFF283618); // hero base

  // --- Accent set (categories / appointments) --------------------------
  static const Color sand = Color(0xFFDDA15E);
  static const Color slateBlue = Color(
    0xFF5E7066,
  ); // muted cool note (supports palette)
  static const Color clay = Color(
    0xFFB0613A,
  ); // brick, kept distinct from primary
  static const Color plum = Color(0xFF5A4256);

  // --- Mood scale (good -> okay -> low : green -> tan -> orange) --------
  static const Color moodGood = forest;
  static const Color moodGoodBg = Color(0xFFE6EAD5);

  static const Color moodOkay = Color(0xFFDDA15E);
  static const Color moodOkayBg = Color(0xFFFBF1D9);

  static const Color moodLow = Color(0xFFBC6C25);
  static const Color moodLowBg = Color(0xFFF6E6D5);

  // --- Feedback ---------------------------------------------------------
  static const Color danger = Color(
    0xFFA8362F,
  ); // true red, distinct from primary

  // --- Lines ------------------------------------------------------------
  static const Color border = Color(0xFFECE3C6); // warm hairline
  static const Color borderSoft = Color.fromARGB(69, 242, 234, 210);

  /// Gradient for the dark-green hero / check-in card.
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFC9A86A), Color(0xFF7E8A4C), Color(0xFF3D4D26)],
    stops: [0.0, 0.5, 1.0],
  );

  // --- Appointments ------------------------------------------------------------
  static const Color psychology = Color(0xFFBC6C25);
  static const Color psychiatrist = Color(0xFFFEFAE0);
  static const Color gp = Color(0xFF866C46);
}
