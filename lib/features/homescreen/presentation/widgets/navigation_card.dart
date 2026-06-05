import 'package:breathe/core/extensions/context_extensions.dart';
import 'package:breathe/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AnimatedCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;
  final IconData icon;

  const AnimatedCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
    required this.icon,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  double _scale = 1.0;

  Widget _icon() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.color.withAlpha(40),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(widget.icon, color: widget.color, size: 22),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.96),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: Border.all(color: AppColors.borderSoft, width: 0.5),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color(0x5728281C),
                offset: Offset(0, 14),
                blurRadius: 30,
                spreadRadius: -18,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _icon(),
                const SizedBox(height: 10),
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  widget.subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
