import 'package:flutter/material.dart';
import 'package:peliculas_app/helpers/helpers.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:peliculas_app/tokens/tokens.dart';

import 'package:peliculas_app/widgets/movie_slider_fav.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: Header(
        title: 'Favoritos',
        leftContent: GestureDetector(
          onTap: pushNamedAndRemoveUntil('home', context, null),
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(width: 1, color: Colors.grey.shade300),
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: MyColors.colorIcon,
              size: 28,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: MovieSliderFavorites(
          movies: moviesProvider.favoriteMovies,
        ),
      ),
    );
  }
}
