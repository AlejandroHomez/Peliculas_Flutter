import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/models/credis_response.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/widgets/myColors.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards(this.movieId);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            width: double.infinity,
            height: 250,
            child: CupertinoActivityIndicator(
              radius: 30,
            ),
          );
        }

        final List<Cast> cast = snapshot.data!;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          width: double.infinity,
          height: 250,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cast.length,
              itemBuilder: (_, int index) => _CrearCards(cast[index])),
        );
      },
    );
  }
}

class _CrearCards extends StatelessWidget {
  final Cast actor;

  const _CrearCards(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        width: 120,
        height: 200,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
              child: FadeInImage(
                placeholder: AssetImage('assets/LoadNew.gif'),
                image: NetworkImage(actor.fullprofilePath),
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              height: 35,
              margin: EdgeInsets.only(top: 7, bottom: 7),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 3,
                        spreadRadius: 0,
                        offset: Offset(0, 3))
                  ],
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        MyColors.colorIcon,
                        Color.fromRGBO(78, 252, 203, 1),
                        Color.fromRGBO(126, 247, 214, 1),
                      ])),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 13,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/LoadNew.gif'),
                        image: NetworkImage(actor.fullprofilePath),
                        fit: BoxFit.cover,
                        width: 26,
                      ),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 3),
                  ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 80),
                      child: Text(
                        actor.name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.overline,
                      )),
                ],
              ),
            )
          ],
        ));
  }
}
