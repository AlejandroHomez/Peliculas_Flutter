import 'package:flutter/material.dart';
import 'package:peliculas_app/customPainters/animation_custompainter.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

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
        curve: Curves.easeInCirc,
        layout: SwiperLayout.STACK,
        itemCount: movies.length,
        itemWidth: size.width * 0.65,
        itemHeight: size.height * 0.45,
        itemBuilder: (_, int index) {
          final movie = movies[index];

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/movieLoad.gif'),
                    image: NetworkImage(movie.fullPosterImg),
                    height: size.height * 0.45,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                      width: 50,
                      height: 50,
                      child: Animation_CustomPainer(movie)),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
