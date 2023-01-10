import 'package:flutter/material.dart';

class CustomInicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return CustomsInicio(size: size);
  }
}

class CustomsInicio extends StatelessWidget {
  const CustomsInicio({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Container(
            width: double.infinity,
            height: size.height,
            // color: Colors.red,
            child: CustomPaint(
              painter: CustomPrincipal2(),
            ),
          ),
        ),
        Opacity(
          opacity: 0.8,
          child: Container(
            width: double.infinity,
            height: size.height,
            // color: Colors.red,
            child: CustomPaint(
              painter: CustomPrincipal3(),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: size.height,
          // color: Colors.red,
          child: CustomPaint(
            painter: CustomPrincipal(),
          ),
        ),
      ],
    );
  }
}

class CustomPrincipal extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // paint1(canvas, size);
    paint1(canvas, size);
    paint2(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void paint1(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    final path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.98, size.height * 0.60,
        size.width * 0.75, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.65, size.height * 0.45,
        size.width * 0.55, size.height * 0.52);
    path.quadraticBezierTo(size.width * 0.4, size.height * 0.60,
        size.width * 0.3, size.height * 0.53);
    path.quadraticBezierTo(size.width * 0.2, size.height * 0.48,
        size.width * 0.07, size.height * 0.55);
    path.quadraticBezierTo(0, size.height * 0.6, 0, size.height * 0.65);
    path.lineTo(0, size.height);
    path.lineTo(0, 150);

    canvas.drawShadow(path, Colors.black45, 2, true);
    canvas.drawPath(path, paint);
    path.moveTo(size.width * 0.3, size.height * 0.6);
  }

  void paint2(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.3, size.height, size.width * 0.4, size.height * 0.97);
    path.quadraticBezierTo(size.width * 0.51, size.height * 0.93,
        size.width * 0.61, size.height * 0.967);
    path.quadraticBezierTo(
        size.width * 0.68, size.height, size.width, size.height);
    canvas.drawPath(path, paint);
  }
}

class CustomPrincipal2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // paint1(canvas, size);
    paint1(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void paint1(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    final path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.98, size.height * 0.55,
        size.width * 0.75, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.65, size.height * 0.48,
        size.width * 0.45, size.height * 0.54);
    path.quadraticBezierTo(size.width * 0.3, size.height * 0.60,
        size.width * 0.22, size.height * 0.54);
    path.quadraticBezierTo(size.width * 0.15, size.height * 0.46,
        size.width * 0.055, size.height * 0.52);
    path.quadraticBezierTo(
        size.width * 0.015, size.height * 0.55, 0, size.height * 0.60);
    path.lineTo(0, size.height);
    path.lineTo(0, 150);
    path.lineTo(180, 150);

    path.arcToPoint(Offset(size.width * 0.55, size.height * 0.48),
        radius: Radius.circular(20), clockwise: false);
    path.arcToPoint(Offset(size.width * 0.44, size.height * 0.22),
        radius: Radius.circular(20), clockwise: false);
    path.lineTo(0, 150);

    canvas.drawPath(path, paint);
  }
}

class CustomPrincipal3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // paint1(canvas, size);
    paint1(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void paint1(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    final path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.4);
    path.quadraticBezierTo(size.width * 0.97, size.height * 0.56,
        size.width * 0.6, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.47,
        size.width * 0.4, size.height * 0.52);
    path.quadraticBezierTo(
        size.width * 0.2, size.height * 0.60, 0, size.height * 0.49);
    // path.quadraticBezierTo( size.width * 0.15, size.height* 0.53, size.width * 0.055, size.height * 0.578);
    // path.quadraticBezierTo( size.width * 0.015 , size.height* 0.6, 0, size.height * 0.65);
    path.lineTo(0, size.height * 0.59);
    path.lineTo(0, 150);
    path.lineTo(180, 150);

    path.arcToPoint(Offset(size.width * 0.55, size.height * 0.48),
        radius: Radius.circular(20), clockwise: false);
    path.arcToPoint(Offset(size.width * 0.44, size.height * 0.22),
        radius: Radius.circular(20), clockwise: false);
    path.lineTo(0, 150);

    canvas.drawPath(path, paint);
  }
}
