import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Problems {
  final String key;
  final IconData icon;

  const Problems({required this.key, required this.icon});
}

List<Problems> problemsList = [
  Problems(key: 'sleep', icon: Icons.nightlight),

  Problems(key: 'work', icon: Icons.work),

  Problems(key: 'family', icon: Icons.family_restroom_outlined),

  Problems(key: 'health', icon: Icons.health_and_safety),

  Problems(key: 'grief', icon: Icons.help),

  Problems(key: 'finances', icon: Icons.help),

  Problems(key: 'studies', icon: Icons.help),

  Problems(key: 'other', icon: Icons.help),
];
