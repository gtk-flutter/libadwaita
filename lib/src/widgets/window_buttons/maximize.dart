import 'package:flutter/material.dart';

class MaximizeWBPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path0 = Path()
      ..moveTo(85, 971)
      ..lineTo(85, 979)
      ..lineTo(93, 979)
      ..lineTo(93, 971)
      ..lineTo(85, 971)
      ..close()
      ..moveTo(87, 973)
      ..lineTo(91, 973)
      ..lineTo(91, 977)
      ..lineTo(87, 977)
      ..lineTo(87, 973)
      ..close();

    final paintFill0 = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawPath(path0, paintFill0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
