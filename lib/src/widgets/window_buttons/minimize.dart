import 'package:flutter/material.dart';

class MinimizeWBPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintFill0 = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(
          size.width / 4.062500,
          size.height * 0.6106312,
          size.width * 0.5000000,
          size.height * 0.1242937,
        ),
      ),
      paintFill0,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
