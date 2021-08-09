import 'package:flutter/material.dart';

Widget degrade(BuildContext context) {
  
  final size = MediaQuery.of(context).size;

  return Container(

    width: size.width * 0.95,
    height: size.height * 0.005,

    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      gradient: LinearGradient (
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [

          Color.fromRGBO(202, 207, 205, 1),
          Color.fromRGBO(182, 182, 182, 1),


        ]
      )
    ),

  );
}