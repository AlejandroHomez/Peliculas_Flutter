import 'package:flutter/material.dart';
import 'package:peliculas_app/infraestructure/tokens/tokens.dart';

class CustomDecoration extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyColors.icon
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    final path = Path();

    path.lineTo(size.width * 0.5, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.5, size.height * 0.75);

    canvas.drawShadow(path, MyColors.black, 4, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
