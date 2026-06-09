import 'package:flutter/material.dart';

class RuledPaperPainter extends CustomPainter {
  final double lineHeight;
  final double offset;
  final Color ruleColor;

  const RuledPaperPainter({
    this.lineHeight = 26,
    this.offset = -4,
    this.ruleColor = const Color.fromARGB(148, 138, 144, 121),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rule = Paint()
      ..color = ruleColor
      ..strokeWidth = 1;

    for (double y = lineHeight + offset; y <= size.height; y += lineHeight) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), rule);
    }
  }

  @override
  bool shouldRepaint(covariant RuledPaperPainter old) =>
      old.lineHeight != lineHeight ||
      old.offset != offset ||
      old.ruleColor != ruleColor;
}
