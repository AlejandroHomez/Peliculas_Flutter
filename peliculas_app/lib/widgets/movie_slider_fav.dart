// ignore_for_file: unnecessary_null_comparison

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peliculas_app/customPainters/animation_custompainterlinea.dart';
import 'package:peliculas_app/helpers/helpers.dart';
import 'package:peliculas_app/models/movie.dart';
import 'package:peliculas_app/models/video_movie_response.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/tokens/tokens.dart';

import 'package:provider/provider.dart';
import 'package:share/share.dart';

class MovieSliderFavorites extends StatefulWidget {
  final List<Movie> movies;

  const MovieSliderFavorites({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSliderFavorites> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (widget.movies.length == 0) return _Mensaje();

    return Container(
      width: double.infinity,
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: widget.movies.length,
              shrinkWrap: true,
              itemBuilder: (_, int index) {
                return ElasticIn(
                  child: MovieFav(
                    widget.movies[index],
                    index,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Mensaje extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      child: Center(
          child: Text(
        'Aun no tienes favoritos',
        style: TextStyle(
            fontFamily: 'AndadaPro', fontSize: 35, color: Colors.grey.shade500),
        textAlign: TextAlign.center,
      )),
    );
  }
}

class MovieFav extends StatelessWidget {
  final Movie movie;
  final int index;

  const MovieFav(this.movie, this.index);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final videoEnlace = Provider.of<VideoEnlace>(context);

    return Builder(
      builder: (_) => Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: pushNamed('details', context, movie),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      FadeInDown(child: _TituloMovie(movie: movie)),
                      Expanded(child: Container()),
                      GestureDetector(
                        onTap: () {
                          moviesProvider.eliminarFavoritos(movie);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Icon(
                            FontAwesomeIcons.solidTrashAlt,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      _IconShare(movie, index),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ZoomIn(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/movieLoad.gif'),
                        image: NetworkImage(movie.fullBackdropPath),
                        fit: BoxFit.cover,
                        height: 160,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      height: 80,
                      child: Column(
                        children: [
                          Text(
                            'Promedio de votos',
                            style: TextStyle(fontFamily: 'AndadaPro'),
                          ),
                          Animation_CustomPainerLinea(movie),
                        ],
                      )),
                  _OverView(movie: movie),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: FutureBuilder(
                future: moviesProvider.getVideoMovie(movie.id),
                builder: (_, AsyncSnapshot<Video> snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      child: CircularProgressIndicator(
                        color: MyColors.colorIcon,
                      ),
                    );
                  }

                  if (snapshot.data!.id != '000') {
                    final Video video = snapshot.data!;

                    videoEnlace.setKey = video.key!;

                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'video', arguments: video);
                      },
                      child: Stack(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                            child: Icon(
                              Icons.play_arrow,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Container();
                }),
          ),
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  const _OverView({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        movie.overview,
        style: TextStyle(color: MyColors.colorText),
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class _TituloMovie extends StatelessWidget {
  const _TituloMovie({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 210,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: MyColors.colorItem))),
      child: Center(
        child: Text(
          movie.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: MyColors.colorText, fontSize: 15, fontFamily: 'AndadaPro'),
        ),
      ),
    );
  }
}

class _IconShare extends StatelessWidget {
  final Movie movie;
  final int index;
  _IconShare(this.movie, this.index);

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
