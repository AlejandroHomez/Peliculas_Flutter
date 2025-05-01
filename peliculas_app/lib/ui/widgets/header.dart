import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({
    required this.title,
    this.leftContent,
    this.rightContent,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget? leftContent;
  final Widget? rightContent;

  @override
  Size get preferredSize => Size.fromHeight(_getPreferredSize());

  double _getPreferredSize() => kToolbarHeight;

  @override
  Widget build(BuildContext context) {
    final emptyBox = SizedBox(width: 50);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      top: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            leftContent != null ? leftContent! : emptyBox,
            _TextAnimation(title: title),
            rightContent != null ? rightContent! : emptyBox,
          ],
        ),
      ),
    );
  }
}

class _TextAnimation extends StatelessWidget {
  const _TextAnimation({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: Duration(seconds: 1),
      curve: Curves.easeInOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value * -100, 0.0),
          child: Transform(
            transform: Matrix4.skewX(value),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'CarterOne',
                color: Colors.black38,
                fontSize: 25,
              ),
            ),
          ),
        );
      },
    );
  }
}
