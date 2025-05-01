import 'package:flutter/material.dart';
import 'package:peliculas_app/infraestructure/tokens/tokens.dart';

import 'dart:io';

class CustomNavigatorBar extends StatelessWidget {
  final IconData? centerIcon;
  final Widget? widgetIcon;
  final Function()? centerIconPressed;

  const CustomNavigatorBar({
    Key? key,
    this.centerIcon,
    this.centerIconPressed,
    this.widgetIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 600),
            width: size.width,
            height: Platform.isIOS ? 85 : 73,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(size.width, Platform.isIOS ? 85 : 73),
                  painter: CustomNavBar(),
                ),
                Center(
                  heightFactor: 0.8,
                  child: CircleAvatar(
                    backgroundColor: MyColors.icon,
                    radius: 30,
                    child: FloatingActionButton(
                      elevation: 5,
                      splashColor: MyColors.grey2,
                      highlightElevation: 12,
                      mini: false,
                      onPressed: () => centerIconPressed != null
                          ? centerIconPressed?.call()
                          : Navigator.of(context).pushNamedAndRemoveUntil(
                              'inicio', (Route<dynamic> route) => false),
                      child: widgetIcon != null
                          ? widgetIcon
                          : Icon(
                              centerIcon ?? Icons.home,
                              size: 35,
                              color: MyColors.icon,
                            ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      backgroundColor: MyColors.white,
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, 'trailers'),
                        icon: Icon(
                          Icons.local_movies,
                          size: 35,
                          color: MyColors.white,
                        ),
                      ),
                      Container(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: () => Navigator.pushNamed(context, 'series'),
                        icon:
                            Icon(Icons.movie, size: 35, color: MyColors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CustomNavBar extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MyColors.icon
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;
    final path = Path()..moveTo(0, 10);

    path.quadraticBezierTo(size.width * 0.20, 20, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 30),
        radius: Radius.circular(20), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 20, size.width, 10);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawShadow(path, MyColors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
