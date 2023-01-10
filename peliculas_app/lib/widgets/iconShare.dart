import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/models/video_movie_response.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/tokens/tokens.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

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
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.all(Radius.circular(8)),
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
            Share.share(
                'Mira el trailer de esta pelicula: \n\nNombre: ${movie.title} \n\nTrailer: $enlace');
          },
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Icon(
              Icons.share,
              color: MyColors.colorIcon,
              size: 24,
            ),
          ),
        );
      },
    );
  }
}
