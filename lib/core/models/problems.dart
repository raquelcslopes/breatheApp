import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Problems {
  final String key;
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color borderColor;

  const Problems({
    required this.key,
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.borderColor,
  });
}

List<Problems> problemsList = [
  Problems(
    key: 'sleep',
    title: 'Sleep',
    icon: Icons.nightlight,
    bgColor: AppColors.moodOkayBg,
    borderColor: AppColors.moodOkay,
  ),

  Problems(
    key: 'work',
    title: 'Work',
    icon: Icons.work,
    bgColor: AppColors.moodOkayBg,
    borderColor: AppColors.moodOkay,
  ),

  Problems(
    key: 'family',
    title: 'Family',
    icon: Icons.family_restroom_outlined,
    bgColor: AppColors.moodOkayBg,
    borderColor: AppColors.moodOkay,
  ),

  Problems(
    key: 'health',
    title: 'Health',
    icon: Icons.health_and_safety,
    bgColor: AppColors.moodOkayBg,
    borderColor: AppColors.moodOkay,
  ),

  Problems(
    key: 'other',
    title: 'Other',
    icon: Icons.help,
    bgColor: AppColors.moodOkayBg,
    borderColor: AppColors.moodOkay,
  ),
];
