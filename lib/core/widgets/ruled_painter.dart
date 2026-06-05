import 'package:flutter/material.dart';

class RuledPaperPainter extends CustomPainter {
  final double lineHeight;
  final Color ruleColor;

  const RuledPaperPainter({
    this.lineHeight = 34,
    this.ruleColor = const Color(0xFFE7DDBD),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rule = Paint()
      ..color = ruleColor
      ..strokeWidth = 1;

    for (double y = lineHeight; y < size.height; y += lineHeight) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), rule);
    }
  }

  @override
  bool shouldRepaint(covariant RuledPaperPainter old) =>
      old.lineHeight != lineHeight || old.ruleColor != ruleColor;
}
