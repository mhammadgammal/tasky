import 'package:flutter/material.dart';
import 'package:tasky/core/theme/app_color.dart';

class CustomCurveWidget extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width, y = size.height;
    Paint paint = Paint()..color = AppColor.mainColor;
    Path path = Path();
    path.lineTo(0, y * .13);
    path.cubicTo(x * .4, -15, x * .77, y * .3, x, y * .07);
    path.lineTo(x, 0);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
