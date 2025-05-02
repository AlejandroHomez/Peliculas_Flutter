import 'package:flutter/material.dart';
import 'package:peliculas_app/peliculas_app.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class IconShare extends StatelessWidget {
  final Movie movie;

  IconShare(this.movie);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
      future: moviesProvider.getVideoMovie(movie.id),
      builder: (_, AsyncSnapshot<Video> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: MyColors.white,
              border: Border.all(color: MyColors.grey3),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Icon(
              Icons.share,
              color: Colors.grey.shade400,
              size: 24,
            ),
          );
        }

        final Video videoEnlace = snapshot.data!;

        final String enlace =
            'https://www.youtube.com/watch?v=${videoEnlace.key}';

        return GestureDetector(
          onTap: () {
            SharePlus.instance.share(
              ShareParams(
                title: 'Mira el trailer de esta pelicula:',
                text: '\n\nNombre: ${movie.title} \n\nTrailer: $enlace',
              ),
            );
          },
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: MyColors.white,
              border: Border.all(color: MyColors.grey3),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Icon(
              Icons.share,
              color: MyColors.icon,
              size: 24,
            ),
          ),
        );
      },
    );
  }
}
