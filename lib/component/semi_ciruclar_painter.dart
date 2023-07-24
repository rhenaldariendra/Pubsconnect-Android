import 'package:flutter/material.dart';
import 'dart:math' as math;

class SemiCirclePainter extends CustomPainter {
  final Color colors;

  SemiCirclePainter({required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final paint = Paint()
      ..color = colors
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height / 2);
    path.arcTo(rect, -math.pi, math.pi, false);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
