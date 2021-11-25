import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:peliculas_app/widgets/movie_slider_vertical.dart';
import 'package:peliculas_app/widgets/myColors.dart';
import 'package:provider/provider.dart';

class TrailersPage extends StatelessWidget {
  const TrailersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(

      appBar: myAppbarTrailers(context, 'Trailers', Icon(Icons.arrow_back_ios_new_rounded, color: MyColors.colorIcon, size: 28,)),

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
        color: Colors.grey.shade200,
          borderRadius:BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          ),
        ),
        child: MovieSliderVertical(
        movies: moviesProvider.popularMoviesVideo,
        onNextPage: () => moviesProvider.getPopularMoviesVideo(),
          ),
      ),
    );
  }
}