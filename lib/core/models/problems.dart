import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Problems {
  final String key;
  final String title;
  final IconData icon;
  final Color bgColor;

  const Problems({
    required this.key,
    required this.title,
    required this.icon,
    required this.bgColor,
  });
}

List<Problems> problemsList = [
  Problems(
    key: 'sleep',
    title: 'Sleep',
    icon: Icons.nightlight,
    bgColor: AppColors.textMuted,
  ),

  Problems(
    key: 'work',
    title: 'Work',
    icon: Icons.work,
    bgColor: AppColors.textMuted,
  ),

  Problems(
    key: 'family',
    title: 'Family',
    icon: Icons.family_restroom_outlined,
    bgColor: AppColors.textMuted,
  ),

  Problems(
    key: 'health',
    title: 'Health',
    icon: Icons.health_and_safety,
    bgColor: AppColors.textMuted,
  ),

  Problems(
    key: 'grief',
    title: 'Grief',
    icon: Icons.help,
    bgColor: AppColors.textMuted,
  ),

  Problems(
    key: 'finances',
    title: 'Finances',
    icon: Icons.help,
    bgColor: AppColors.textMuted,
  ),

  Problems(
    key: 'studies',
    title: 'Studies',
    icon: Icons.help,
    bgColor: AppColors.textMuted,
  ),

  Problems(
    key: 'other',
    title: 'Other',
    icon: Icons.help,
    bgColor: AppColors.textMuted,
  ),
];
