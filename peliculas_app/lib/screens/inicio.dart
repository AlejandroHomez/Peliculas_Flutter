import 'package:flutter/material.dart';
import 'package:peliculas_app/customPainters/customs.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:peliculas_app/serach/search_delegate.dart';

class InicioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 10,
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: PageView(
          scrollDirection: Axis.vertical,
          children: [
            BackPage1(),
            HomeScreen(),
          ],
        ));
  }
}

class BackPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      children: [
        DecorationInico(),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            SafeArea(
              child: Text(
                "Información de\n Películas y Series",
                style: TextStyle(fontSize: 30, fontFamily: 'CarterOne'),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
            Expanded(child: Container()),
            ButtonsContainer(),
            Center(
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, 'home'),
                icon: Icon(
                  Icons.expand_more,
                  size: 40,
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}

class ButtonsContainer extends StatelessWidget {
  const ButtonsContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
        left: size.width * 0.1,
        right: size.width * 0.1,
      ),

      width: double.infinity,
      height: 250,
      // color: Colors.white,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 0.0),
              curve: Curves.easeOutBack,
              duration: Duration(milliseconds: 1000),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(value * -200, 0.0),
                  child: child,
                );
              },
              child: GestureDetector(
                  onTap: () => showSearch(
                      context: context, delegate: MovieSearchDelegate()),
                  child: DetailsButtons(
                      title: "Buscar una Pelicula", icon: Icons.search)),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 0.0),
              curve: Curves.easeOutBack,
              duration: Duration(milliseconds: 1200),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(value * -200, 0.0),
                  child: child,
                );
              },
              child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'home'),
                  child: DetailsButtons(
                      title: "Información de Peliculas", icon: Icons.movie)),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 1.0, end: 0.0),
              curve: Curves.easeOutBack,
              duration: Duration(milliseconds: 1400),
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(value * -200, 0.0),
                  child: child,
                );
              },
              child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'series'),
                  child: DetailsButtons(
                      title: "Información de Series",
                      icon: Icons.list_rounded)),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsButtons extends StatelessWidget {
  final String title;
  final IconData icon;

  const DetailsButtons({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 5)
      ],
      gradient: LinearGradient(
        colors: [
          Color.fromRGBO(42, 237, 140, 1),
          Color.fromRGBO(42, 237, 213, 1),
        ],
      ),
    );

    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.7,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: boxDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(
              icon,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(color: Colors.black, fontFamily: 'CarterOne'),
          )
        ],
      ),
    );
  }
}

class DecorationInico extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          height: size.height,
          color: Colors.black,
          child: Stack(
            children: [
              CustomInicio(),
              Positioned(
                top: size.height * 0.2,
                // right: size.width /2,
                child: Container(
                  width: size.width,
                  // color: Colors.red,
                  child: Image(
                    image: AssetImage('assets/IconoMovies.png'),
                    height: 180,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
