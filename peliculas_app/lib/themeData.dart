import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peliculas_app/peliculas_app.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    appBarTheme: AppBarTheme(
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle:
          SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
    ),
    brightness: Brightness.light,
    primaryTextTheme: Theme.of(context).primaryTextTheme.apply(
          bodyColor: MyColors.black.withOpacity(0.6),
        ),
  );
}
