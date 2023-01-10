import 'dart:math';
import 'dart:ui';

import 'package:peliculas_app/tokens/tokens.dart';

import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';

class Animation_CustomPainer extends StatefulWidget {
  final Movie movie;
  Animation_CustomPainer(this.movie);

  @override
  State<Animation_CustomPainer> createState() => _Animation_CustomPainerState();
}

class _Animation_CustomPainerState extends State<Animation_CustomPainer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> progressAnimation;

  double porcentaje = 0.0;
  double nuevoPorcentaje = 0.0;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));

    progressAnimation =
        CurvedAnimation(parent: controller, curve: const Interval(0.0, 1.0));

    controller.addListener(() {
      setState(() {
        porcentaje = lerpDouble(porcentaje, nuevoPorcentaje, controller.value)!;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: controller,
          builder: (context, Widget? child) {
            return Container(
              padding: const EdgeInsets.all(5),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.black12, shape: BoxShape.circle),
                    child: Center(
                        child: Text(
                      '${(widget.movie.voteAverage * 10).toInt()}%',
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'AndadaPro'),
                    )),
                  ),
                  CustomPaint(
                    size: const Size.fromHeight(200),
                    painter: _ProgressPainter(widget.movie.voteAverage),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    ));
  }
}

class _ProgressPainter extends CustomPainter {
  final valor;
  _ProgressPainter(this.valor);

  @override
  void paint(Canvas canvas, Size size) {
    //Circulo Base

    final paint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke;

    final path = Path();
    final c = Offset(size.width * 0.5, size.height * 0.5);
    final radius = min(size.width * 0.5, size.height * 0.5);

    canvas.drawCircle(c, radius, paint);

    //lo que se llena

    final Rect rect = Rect.fromCircle(center: Offset(2, 0), radius: 20);

    final Gradient gradient = LinearGradient(
        // transform: GradientRotation(pi / 1.8),
        // stops: [0.01 ,0.08],
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [MyColors.colorIcon, Colors.blueAccent]);

    final paintProgress = Paint()
      ..shader = gradient.createShader(rect)
      ..color = MyColors.colorIcon
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(rect);

    double arcAngle = 2 * pi * (valor * 0.1);

    canvas.drawArc(Rect.fromCircle(center: c, radius: radius), -pi / 2,
        arcAngle, false, paintProgress);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
