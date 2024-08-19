import 'package:flutter/material.dart';

class DonutClipper extends CustomClipper<Path> {
  const DonutClipper();
  @override
  Path getClip(Size size) {
    Path path = Path();
    double outerRadius = size.width / 2;
    double innerRadius = outerRadius / 2;

    // Outer circle
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: outerRadius));

    // Inner circle to cut out
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: innerRadius));

    // Using `Path.fillType` to clip the inner part, creating a donut shape
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
