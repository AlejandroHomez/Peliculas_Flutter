import 'package:flutter/material.dart';
import 'package:peliculas_app/customPainters/customs.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:peliculas_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: myAppbar(context),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Stack(
              children: [
                SafeArea(
                  child: Column(
                    children: [
                      degrade(context),
                      CardSwiper(movies: moviesProvider.onDisplayMovie),
                      Container(
                        width: double.infinity,
                        height: 25,
                        // color: Colors.red,
                        child: CustomPaint(
                          painter: CustomDecoration(),
                        ),
                      ),
                      MovieSlider(
                        movies: moviesProvider.popularMovies,
                        onNextPage: () => moviesProvider.getPopularMovies(),
                        title: 'Pupulares',
                      ),
                      degrade(context),
                      MovieSlider(
                        onNextPage: () => moviesProvider.getUpcomingMovies(),
                        movies: moviesProvider.upcomingMovies,
                        title: 'Proximamente',
                      ),
                      SizedBox(
                        height: 60,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomNavigatorBar()
        ],
      ),
    );
  }
}
