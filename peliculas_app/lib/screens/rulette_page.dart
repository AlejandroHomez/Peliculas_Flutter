import 'package:flutter/material.dart';
import 'package:peliculas_app/helpers/helpers.dart';
import 'package:peliculas_app/screens/screens.dart';

class RulettePage extends StatelessWidget {
  const RulettePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: Header(
        title: 'Ruleta',
        leftContent: IconButton(
          onPressed: pop(context),
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Center(
        child: Container(
          width: size.width * 0.6,
          height: size.width * 0.6,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
