import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:peliculas_app/customPainters/customs.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/widgets/degrade.dart';
import 'package:peliculas_app/widgets/myColors.dart';
import 'package:peliculas_app/screens/screens.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
          slivers: [
            _CustomAppbar(movie: movie),
            SliverList(
                delegate: SliverChildListDelegate([
              DetailsMovie(movie),

              // ClasPeliculas(movie.genreIds, movie),

              Padding(
                padding: EdgeInsets.all(8.0),
                child: degrade(context),
              ),
              _OverView(
                movie: movie,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: degrade(context),
              ),
              CastingCards(movie.id),
              SizedBox(height: 80)
            ]))
          ],
        ),
        CustomNavigatorBar()
      ],
    ));
  }
}

class _CustomAppbar extends StatelessWidget {
  final Movie movie;

  const _CustomAppbar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    timeDilation = 1.0;

    return SliverAppBar(
      collapsedHeight: 64,
      automaticallyImplyLeading: false,
      backgroundColor: MyColors.colorIcon,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.all(0),
        centerTitle: true,
        title: Container(
            padding: EdgeInsets.only(
              bottom: size.width * 0.035,
            ),
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: 3, top: 3),
              width: double.infinity,
              height: size.height * 0.05,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Colors.transparent,
                    Colors.black54,
                    Colors.black,
                    Colors.black,
                    Colors.black54,
                    Colors.transparent,
                  ])),
              child: Text(
                movie.title,
                style: TextStyle(
                    color: Colors.white, fontFamily: 'CarterOne', fontSize: 11),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            )),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class DetailsMovie extends StatelessWidget {
  final Movie movie;

  const DetailsMovie(this.movie);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    timeDilation = 1.5;

    return Padding(
      padding: EdgeInsets.only(left: 10.0, top: 10),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
                child: FadeInImage(
                  placeholder: AssetImage('assets/CicleLoad.gif'),
                  image: NetworkImage(movie.fullPosterImg),
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 10),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width - 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline5),
                  Text(movie.originalTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1),
                  SizedBox(
                    height: 5,
                  ),
                  Text('${movie.voteAverage}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.amber,
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
    ThemeData.light();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      child: Text(
        movie.overview,
        style: Theme.of(context).textTheme.subtitle1,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
