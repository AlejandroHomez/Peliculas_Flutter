import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/tokens/tokens.dart';

class Animation_CustomPainerLinea extends StatefulWidget {
  final Movie movie;
  const Animation_CustomPainerLinea(this.movie);

  @override
  State<Animation_CustomPainerLinea> createState() =>
      _Animation_CustomPainerState();
}

class _Animation_CustomPainerState extends State<Animation_CustomPainerLinea>
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
    return Container(
      width: 300,
      height: 35,
      padding: const EdgeInsets.all(5),
      child: Stack(
        children: [
          CustomPaint(
            size: const Size.fromHeight(double.infinity),
            painter: _ProgressPainter(widget.movie.voteAverage),
          ),
          Center(
            child: Container(
              height: 30,
              decoration: BoxDecoration(),
              child: Center(
                child: Text(
                  '${(widget.movie.voteAverage * 10).toInt()}%',
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'AndadaPro'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
      ..strokeWidth = 13
      ..style = PaintingStyle.stroke;

    final p1 = Offset(0.0, size.height * 0.5);
    final p2 = Offset(size.width, size.height * 0.5);

    canvas.drawLine(p1, p2, paint);

    //lo que se llena

    final Rect rect = Rect.fromCircle(center: Offset(180, 0), radius: 50);

    final Gradient gradient = LinearGradient(
        // transform: GradientRotation(pi / 1.8),
        // stops: [0.01 ,0.08],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [MyColors.colorIcon, Colors.blueAccent]);

    final paintProgress = Paint()
      ..shader = gradient.createShader(rect)
      ..color = MyColors.colorIcon
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(rect);

    double relleno = valor * 0.1;

    final p1p = Offset(0.0, size.height * 0.5);
    final p2p = Offset(size.width * relleno, size.height * 0.5);

    canvas.drawLine(p1p, p2p, paintProgress);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
