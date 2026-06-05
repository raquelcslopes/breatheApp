import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Moods {
  final String key;
  final String title;
  final Color bgColor;

  const Moods({required this.key, required this.title, required this.bgColor});
}

List<Moods> moods = [
  Moods(key: 'low', title: 'Low', bgColor: AppColors.moodLow),
  Moods(key: 'okay', title: 'Okay', bgColor: AppColors.moodOkay),
  Moods(key: 'good', title: 'Good', bgColor: AppColors.moodGood),
];
