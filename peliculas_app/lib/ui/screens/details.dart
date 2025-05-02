import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peliculas_app/peliculas_app.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(
              children: [
                _AppBarDetails(movie),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          DetailsMovie(movie),
                          Positioned(
                            bottom: 10,
                            right: 15,
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.solidStar,
                                  size: 15,
                                  color: Colors.yellow.shade600,
                                ),
                                Container(
                                  width: 150,
                                  height: 30,
                                  child: Animation_CustomPainer_Linea(movie),
                                ),
                                SizedBox(width: 15),
                                _IconFavorite(movie)
                              ],
                            ),
                          ),
                        ],
                      ),
                      ZoomIn(
                        child: ClasPeliculas(movie.genreIds),
                      ),
                      _OverView(
                        movie: movie,
                      ),
                      SizedBox(height: 5),
                      FadeInRightBig(
                        child: CastingCards(movie.id),
                      ),
                      SizedBox(height: 80)
                    ],
                  ),
                )
              ],
            ),
          ),
          CustomNavigatorBar(
            centerIconPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil(
                    'home', (Route<dynamic> route) => false),
          )
        ],
      ),
    );
  }
}

class _AppBarDetails extends StatefulWidget {
  final Movie movie;
  const _AppBarDetails(
    this.movie,
  );

  @override
  State<_AppBarDetails> createState() => _AppBarDetailsState();
}

class _AppBarDetailsState extends State<_AppBarDetails> {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: MyColors.black,
          height: size.height * 0.28,
          child: Stack(
            alignment: Alignment.center,
            children: [
              FadeInImage(
                placeholder: AssetImage('assets/movieLoad.gif'),
                image: NetworkImage(widget.movie.fullBackdropPath),
                fit: BoxFit.cover,
                height: double.infinity,
              ),
              Container(
                color: Colors.black26,
                height: double.infinity,
                width: double.infinity,
              ),
              FutureBuilder(
                future: moviesProvider.getVideoMovie(widget.movie.id),
                builder: (_, AsyncSnapshot<Video> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }

                  if (snapshot.data!.id != '000') {
                    final Video video = snapshot.data!;

                    return TweenAnimationBuilder<double>(
                      tween: Tween(begin: 1.0, end: 0.0),
                      curve: Curves.easeOutBack,
                      duration: Duration(seconds: 1),
                      builder: (context, value, child) {
                        return Transform.translate(
                          offset: Offset(value * -200, 0.0),
                          child: child,
                        );
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'video',
                              arguments: video);
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: MyColors.icon,
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: MyColors.white, width: 2),
                          ),
                          child: Icon(
                            Icons.play_arrow,
                            size: 35,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context, 'home'),
                  icon: Icon(
                    Icons.reply_rounded,
                    color: Colors.white54,
                    size: 30,
                  ),
                ),
                Transform.scale(
                  scale: 1.2,
                  child: IconShare(widget.movie),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DetailsMovie extends StatelessWidget {
  final Movie movie;

  const DetailsMovie(this.movie);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                curve: Curves.easeInOutBack,
                duration: Duration(seconds: 2),
                builder: (context, double value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: FadeInImage(
                  placeholder: AssetImage('assets/movieLoad.gif'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(width: 10),

            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 200, minWidth: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(height: 15),
                  Text(
                    'Nombre original:',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 15, fontFamily: 'CarterOne'),
                  ),
                  Text(movie.originalTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  final Movie movie;

  const _OverView({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return movie.overview.isEmpty
        ? Container()
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: double.infinity,
            // height: 300,
            child: Text(
              movie.overview,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontFamily: 'AndadaPro',
                fontSize: 18,
                color: Colors.grey.shade700,
              ),
            ),
          );
  }
}

class _IconFavorite extends StatelessWidget {
  final Movie movie;
  _IconFavorite(this.movie);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    for (var i = 0; i < moviesProvider.favoriteMovies.length; i++) {
      if (moviesProvider.favoriteMovies[i].id == movie.id) {
        return GestureDetector(
          onTap: () {
            moviesProvider.eliminarFavoritos(movie);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: MyColors.item,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Pulse(
              duration: Duration(milliseconds: 400),
              child: Icon(FontAwesomeIcons.solidBookmark,
                  color: MyColors.white, size: 25),
            ),
          ),
        );
      }
    }

    return GestureDetector(
      onTap: () {
        moviesProvider.getFavoriteMovies(movie);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: MyColors.icon,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        child: ElasticIn(
          child: Icon(
            FontAwesomeIcons.bookmark,
            color: MyColors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
}
