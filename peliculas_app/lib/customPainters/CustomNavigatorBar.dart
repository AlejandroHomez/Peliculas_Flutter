import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/screens.dart';

class CustomNavigatorBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: Container(
            width: size.width,
            height: 73,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(size.width, 73),
                  painter: CustomNavBar(),
                ),
                Center(
                  heightFactor: 0.8,
                  child: CircleAvatar(
                    backgroundColor: MyColors.colorIcon,
                    radius: 30,
                    child: FloatingActionButton(
                      elevation: 5,
                      splashColor: Colors.grey.shade200,
                      highlightElevation: 12,
                      mini: false,
                      onPressed: () => Navigator.pushNamed(context, 'home'),
                      child: Icon(
                        Icons.home,
                        size: 35,
                        color: MyColors.colorIcon,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                Container(
                  width: size.width,
                  height: 80,
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.play_arrow_sharp,
                            size: 35,
                            color: Colors.white,
                          )),
                      Container(
                        width: 10,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon:
                              Icon(Icons.movie, size: 35, color: Colors.white)),
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
      ..color = MyColors.colorIcon
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

    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
