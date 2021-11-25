import 'package:flutter/material.dart';

  ThemeData  themeData(BuildContext context) {

    return ThemeData(
      
        // brightness: Brightness.dark,
        primaryColor: Colors.red,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: 
          IconThemeData(
            color: Colors.black.withOpacity(0.5)
            
            ),
          ),

          primaryTextTheme: Theme.of(context).primaryTextTheme.apply(
          bodyColor: Colors.black.withOpacity(0.6)),

);

 }

       