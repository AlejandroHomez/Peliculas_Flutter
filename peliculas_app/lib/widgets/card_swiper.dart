import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:peliculas_app/screens/screens.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (this.movies.length == 0) {
      return Container(
        width: double.infinity,
        height: size.height * 0.6,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(20),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemCount: movies.length,
        itemWidth: size.width * 0.65,
        itemHeight: size.height * 0.45,
        itemBuilder: (_, int index) {
          final movie = movies[index];

          movie.heroId = 'swiper-${movie.id}';

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: FadeInImage(
                  placeholder: AssetImage('assets/loading.gif'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
