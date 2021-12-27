import 'package:flutter/material.dart';

class CustomSliderThumb extends SliderComponentShape {
  final double thumbRadius;
  final double max;

  CustomSliderThumb(this.thumbRadius, {this.max = 1.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final Canvas canvas = context.canvas;

    final paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final paint2 = Paint()
      ..color = Colors.grey.shade400
      ..style = PaintingStyle.stroke;

    TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: thumbRadius * .8,
        fontWeight: FontWeight.w700,
        color: sliderTheme.thumbColor,
      ),
      text: getValue(value),
    );

    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, thumbRadius * .9, paint1);
    canvas.drawCircle(center, thumbRadius * .9, paint2);

    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (value * max).round().toString();
  }
}
