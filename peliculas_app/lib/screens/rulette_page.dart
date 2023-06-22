import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peliculas_app/helpers/helpers.dart';
import 'package:peliculas_app/providers/providers.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:provider/provider.dart';

import '../customPainters/animation_custompainterlinea.dart';
import '../models/movie.dart';

class RulettePage extends StatefulWidget {
  RulettePage({Key? key}) : super(key: key);

  @override
  State<RulettePage> createState() => _RulettePageState();
}

class _RulettePageState extends State<RulettePage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late MoviesProvider moviesProvider;
  late List<Movie> movies;
  int randomLeft = 0;
  int randomCenter = 0;
  int randomRight = 0;
  int moviesLength = 0;

  @override
  void initState() {
    moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));

    movies = moviesProvider.popularMovies;
    movies.addAll(moviesProvider.topRateMovies);
    movies.addAll(moviesProvider.upcomingMovies);

    moviesLength = movies.length;

    randomLeft = random.nextInt(moviesLength);
    randomCenter = random.nextInt(moviesLength);
    randomRight = random.nextInt(moviesLength);

    // _animationController.addStatusListener((status) {
    //   if (status.index == 0.8) {
    //     print(status.index);
    //     moviesLength = movies.length;

    //     setState(() {
    //       randomLeft = random.nextInt(moviesLength);
    //       randomCenter = random.nextInt(moviesLength);
    //       randomRight = random.nextInt(moviesLength);
    //     });
    //   }
    //   _animationController.reset();
    // });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final size = MediaQuery.of(context).size;

    Movie centerMovie = moviesProvider.popularMovies[randomLeft];
    Movie leftMovie = moviesProvider.popularMovies[randomCenter];
    Movie rightMovie = moviesProvider.popularMovies[randomRight];

    return Scaffold(
      appBar: Header(
        title: 'Ruleta',
        leftContent: IconButton(
          onPressed: pop(context),
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CardRoulette(
                          movie: leftMovie,
                          sizeHeight: 400,
                          sizeWith: size.width * 0.135,
                          isSelected: false,
                        ),
                        CardRoulette(
                          movie: centerMovie,
                          sizeHeight: 600,
                          sizeWith: size.width * 0.6,
                          isSelected: true,
                        ),
                        CardRoulette(
                          movie: rightMovie,
                          sizeHeight: 400,
                          sizeWith: size.width * 0.135,
                          isSelected: false,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    width: size.width,
                    child: Column(
                      children: [
                        Text(
                          '¿ Aceptas el reto ? \n Ve a ver esta pelicula!!',
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'CarterOne',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          centerMovie.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'AndadaPro',
                          ),
                        ),
                        Text(
                          'Promedio de votos',
                          style: TextStyle(fontFamily: 'AndadaPro'),
                        ),
                        Animation_CustomPainerLinea(centerMovie),
                        const SizedBox(height: 100),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 35,
            left: 50,
            right: 50,
            child: GestureDetector(
              onTap: (() {
                setState(() {
                  List<int> generatedNumbers = [];

                  while (generatedNumbers.length < 3) {
                    int randomNumber = random.nextInt(moviesLength);
                    if (!generatedNumbers.contains(randomNumber)) {
                      generatedNumbers.add(randomNumber);
                    }
                  }

                  randomLeft = generatedNumbers[0];
                  randomCenter = generatedNumbers[1];
                  randomRight = generatedNumbers[2];
                });
              }),
              child: Container(
                padding: EdgeInsets.all(8.0),
                width: size.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(42, 237, 140, 1),
                      Color.fromRGBO(42, 237, 213, 1),
                    ],
                  ),
                ),
                child: Text(
                  'Pelicula al azar',
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'CarterOne',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CardRoulette extends StatelessWidget {
  const CardRoulette({
    Key? key,
    required this.movie,
    required this.sizeHeight,
    required this.sizeWith,
    required this.isSelected,
  }) : super(key: key);

  final Movie movie;
  final double sizeWith;
  final double sizeHeight;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    VoidCallback onTap = pushNamed('details', context, movie);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: isSelected ? onTap : () {},
        child: Opacity(
          opacity: isSelected ? 1.0 : 0.5,
          child: Container(
            width: sizeWith,
            height: sizeHeight,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: FadeInImage(
                placeholder: AssetImage('assets/movieLoad.gif'),
                image: NetworkImage(movie.fullPosterImg),
                height: size.height * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
