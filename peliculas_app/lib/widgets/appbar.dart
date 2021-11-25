import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:peliculas_app/serach/search_delegate.dart';
import 'package:peliculas_app/widgets/myColors.dart';

AppBar myAppbar(BuildContext context, String title, Icon? icon) {

return AppBar(
        leading: icon == null
        ? Container()
        : Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: icon, onPressed: () =>  Navigator.of(context).pushNamedAndRemoveUntil(
                  'home', (Route<dynamic> route) => false),
            
            ),
        ),
        
        title: TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0 , end: 0.0),
          duration: Duration(seconds: 1) ,
          curve: Curves.easeInOutBack,
          builder:(context, value, child) {
            return Transform.translate(
              offset: Offset(value * - 100, 0.0) ,
              child: Transform(
                transform: Matrix4.skewX(value),
                child: child,
                ),
            );
          } ,
          child: Text(
            title,
            style: TextStyle(fontFamily: 'CarterOne', color: Colors.black38, fontSize: 25),
            ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(7.0),
            child: GestureDetector(
              onTap: () =>
              showSearch(context: context, delegate: MovieSearchDelegate()),
              child: CircleAvatar(
                backgroundColor: MyColors.colorIcon,
                child: Icon(Icons.search_outlined, color: Colors.white)
                ),
            ),
          )

        ],
      );

}


AppBar myAppbarTrailers(BuildContext context, String title, Icon? icon) {
  return AppBar(
    leading: icon == null
        ? Container()
        : Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  'home', (Route<dynamic> route) => false),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 1, color: Colors.grey.shade300)
              ),
              child: icon),
          ),
        ),
    title: TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: 0.0),
      duration: Duration(seconds: 1),
      curve: Curves.easeInOutBack,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(value * -100, 0.0),
          child: Transform(
            transform: Matrix4.skewX(value),
            child: child,
          ),
        );
      },
      child: Text(
        title,
        style: TextStyle(
            fontFamily: 'CarterOne', color: Colors.black38, fontSize: 25),
      ),
    ),
  );
}
