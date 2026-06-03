import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Moods {
  final String key;
  final String title;
  final Color bgColor;
  final Color borderColor;
  final String asset;

  const Moods({
    required this.key,
    required this.title,
    required this.bgColor,
    required this.borderColor,
    required this.asset,
  });
}

List<Moods> moods = [
  Moods(
    key: 'low',
    title: 'Low',
    bgColor: AppColors.moodLowBg,
    borderColor: AppColors.moodLow,
    asset: 'lib/assets/low_mood.png',
  ),
  Moods(
    key: 'okay',
    title: 'Okay',
    bgColor: AppColors.moodOkayBg,
    borderColor: AppColors.moodOkay,
    asset: 'lib/assets/okay_mood.png',
  ),
  Moods(
    key: 'good',
    title: 'Good',
    bgColor: AppColors.moodGoodBg,
    borderColor: AppColors.moodGood,
    asset: 'lib/assets/good_mood.png',
  ),
];
