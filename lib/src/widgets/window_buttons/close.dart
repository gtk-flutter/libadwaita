// ignore_for_file: cascade_invocations
import 'package:flutter/material.dart';

class CloseWBPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path_0 = Path()
      ..moveTo(45, 764)
      ..lineTo(46, 764)
      ..cubicTo(46.01037, 762.8, 42, 764.02079, 41.4, 760)
      ..cubicTo(41.43125, 760, 41.65495, 760.0112, 41.90987, 760.12858)
      ..cubicTo(
        42.59737,
        760.44108,
        double.nan,
        double.nan,
        double.nan,
        double.nan,
      )
      ..close();

    final paintFill0 = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawPath(path_0, paintFill0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
