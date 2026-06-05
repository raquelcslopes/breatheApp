import 'package:flutter/material.dart';

class AppColorsDark {
  AppColorsDark._();

  // --- Surfaces (warm browns, not black) ---
  static const Color background = Color(0xFF26201A); // dark coffee
  static const Color surface = Color(0xFF332B23); // raised card
  static const Color surfaceAlt = Color(0xFF3D342A); // recessed / tinted

  // --- Text ---
  static const Color textPrimary = Color(0xFFF1E9D6); // warm cream
  static const Color textSecondary = Color(0xFFC3B79E);
  static const Color textMuted = Color(0xFF94896F);
  static const Color onAction = Color(
    0xFF26201A,
  ); // dark text on bright accents
  static const Color onDark = Color(0xFFF1E9D6);

  // --- Brand / action (lifted for contrast) ---
  static const Color primary = Color(0xFFD98A47); // burnt orange, brighter
  static const Color primarySoft = Color(0xFFE6B978);

  // --- Green (structural) ---
  static const Color forest = Color(0xFF8B9A5E); // olive, lifted
  static const Color forestDeep = Color(0xFF3A4A26);

  // --- Accent set ---
  static const Color sand = Color(0xFFE6B978);
  static const Color slateBlue = Color(0xFF7E9085);
  static const Color clay = Color(0xFFCB8159);
  static const Color plum = Color(0xFF8C6E84);

  // --- Mood (lifted so it reads on dark) ---
  static const Color moodGood = Color(0xFF8B9A5E);
  static const Color moodGoodBg = Color(0xFF38402A);
  static const Color moodOkay = Color(0xFFE0B068);
  static const Color moodOkayBg = Color(0xFF433829);
  static const Color moodLow = Color(0xFFD98A47);
  static const Color moodLowBg = Color(0xFF40342A);

  // --- Feedback ---
  static const Color danger = Color(0xFFD66A60); // lifted red

  // --- Lines ---
  static const Color border = Color(0xFF463B2F); // warm dark hairline
  static const Color borderSoft = Color(0x40463B2F);

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF4A3C28), Color(0xFF3A4A26), Color(0xFF241D16)],
    stops: [0.0, 0.5, 1.0],
  );

  // --- Appointments ---
  static const Color psychology = Color(0xFFD98A47);
  static const Color psychiatrist = Color(0xFF8B9A5E);
  static const Color gp = Color(0xFFB89366);
}
