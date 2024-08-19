import 'dart:math' show pi;

import 'package:flutter/material.dart';

class DonutClipperProgressive extends CustomClipper<Path> {
  final double progress;

  DonutClipperProgressive({required this.progress});

  @override
  Path getClip(Size size) {
    Path path = Path();
    double outerRadius = size.width / 2;
    double innerRadius = outerRadius / 2;

    // Draw the outer arc based on the progress
    path.addArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: outerRadius),
      -progress * 2 * pi, // Start angle based on progress
      2 * pi, // Sweep angle (full circle)
    );

    // Subtract the inner circle to create the donut shape
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: innerRadius));

    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(DonutClipperProgressive oldClipper) {
    return oldClipper.progress != progress;
  }
}
