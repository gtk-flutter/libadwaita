// ignore_for_file: cascade_invocations
import 'package:flutter/material.dart';

class CloseWBPainter extends CustomPainter {
  CloseWBPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path_0 = Path()
      ..moveTo(size.width * 2.812500, size.height * 47.75000);
    path_0.lineTo(size.width * 2.875000, size.height * 47.75000);
    path_0.cubicTo(
      size.width * 0.02875648,
      size.height * .4767500,
      size.width * .02625000,
      size.height * .4775130,
      size.width * .02587500,
      size.height * .4750000,
    );
    path_0.cubicTo(
      size.width * .02589453,
      size.height * .4750000,
      size.width * .02603434,
      size.height * .4750070,
      size.width * .02619367,
      size.height * .4750804,
    );
    path_0.cubicTo(
      size.width * .02662336,
      size.height * .4752757,
      size.width * double.nan,
      size.height * double.nan,
      size.width * double.nan,
      size.height * double.nan,
    );
    path_0.lineTo(size.width * 0.03062500, size.height * 0.4791211);
    path_0.lineTo(size.width * 0.03207031, size.height * 0.4776953);
    path_0.cubicTo(
      size.width * 0.03223633,
      size.height * 0.4775512,
      size.width * 0.03234948,
      size.height * 0.4775044,
      size.width * 0.03250000,
      size.height * 0.4775000,
    );
    path_0.lineTo(size.width * 3.312500, size.height * 47.75000);
    path_0.lineTo(size.width * 3.312500, size.height * 47.81250);
    path_0.cubicTo(
      size.width * 3.312500,
      size.height * 47.83040,
      size.width * 3.310354,
      size.height * 47.84692,
      size.width * 3.296875,
      size.height * 47.85938,
    );
    path_0.lineTo(size.width * 3.154297, size.height * 48.00195);
    path_0.lineTo(size.width * 3.294922, size.height * 48.14258);
    path_0.cubicTo(
      size.width * 3.306684,
      size.height * 48.15434,
      size.width * 3.312499,
      size.height * 48.17092,
      size.width * 3.312500,
      size.height * 48.18750,
    );
    path_0.lineTo(size.width * 3.312500, size.height * 48.25000);
    path_0.lineTo(size.width * 3.250000, size.height * 48.25000);
    path_0.cubicTo(
      size.width * 3.233419,
      size.height * 47.62500,
      size.width * 2.875000,
      size.height * 48.21684,
      size.width * 3.244181,
      size.height * 48.20508,
    );
    path_0.cubicTo(
      size.width * 3.226603,
      size.height * double.nan,
      size.width * double.nan,
      size.height * double.nan,
      size.width * double.nan,
      size.height * double.nan,
    );
    path_0.lineTo(size.width * 3.062500, size.height * 48.08984);
    path_0.lineTo(size.width * 2.919922, size.height * 48.23242);
    path_0.cubicTo(
      size.width * 2.908162,
      size.height * 48.24418,
      size.width * 2.891581,
      size.height * 48.25000,
      size.width * 2.875000,
      size.height * 48.25000,
    );
    path_0.lineTo(size.width * 2.812500, size.height * 48.25000);
    path_0.lineTo(size.width * 2.812500, size.height * 48.18750);
    path_0.cubicTo(
      size.width * 2.625000,
      size.height * 47.81250,
      size.width * 2.795919,
      size.height * 48.19332,
      size.width * 2.779339,
      size.height * 48.20508,
    );
    path_0.cubicTo(
      size.width * 2.734417,
      size.height * double.nan,
      size.width * double.nan,
      size.height * double.nan,
      size.width * double.nan,
      size.height * double.nan,
    );
    path_0.lineTo(size.width * double.nan, size.height * double.nan);
    path_0.lineTo(size.width * 2.830078, size.height * 47.85938);
    path_0.cubicTo(
      size.width * 2.816907,
      size.height * 47.84721,
      size.width * 2.811131,
      size.height * 47.83005,
      size.width * 2.812500,
      size.height * 47.81250,
    );
    path_0.lineTo(size.width * 2.812500, size.height * 47.75000);
    path_0.close();

    final paintFill0 = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawPath(path_0, paintFill0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
