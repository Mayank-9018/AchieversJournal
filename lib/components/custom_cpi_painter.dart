import 'dart:math';

import 'package:flutter/material.dart';

class CustomCPI extends CustomPainter {
  final double percentage;
  final Color color;
  CustomCPI(this.percentage,this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final shapeBounds2 = Rect.fromLTRB(5, 5, size.width - 5, size.height - 5);

    final paint1 = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;
    final paint2 = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    const double start = 3 * pi / 2;
    final double end = (360 * percentage / 1) * pi / 180;

    canvas.drawArc(shapeBounds2, start, end, false, paint1);

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint2);
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2 - 11, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
