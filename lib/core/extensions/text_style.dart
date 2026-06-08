import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle diaryBody = GoogleFonts.newsreader(
    fontSize: 16,
    height: 26 / 16,
  );

  static TextStyle diaryHint = GoogleFonts.newsreader(
    fontSize: 16,
    height: 26 / 16,
    fontStyle: FontStyle.italic,
    color: AppColors.textMuted,
  );
}
