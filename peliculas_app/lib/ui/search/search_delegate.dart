import 'package:flutter/material.dart';
import 'package:peliculas_app/peliculas_app.dart';

import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => "Buscar";

  @override
  TextInputType? get keyboardType => TextInputType.visiblePassword;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(backgroundColor: MyColors.white),
      primaryIconTheme: IconThemeData(color: MyColors.icon),
      textSelectionTheme: TextSelectionThemeData(cursorColor: MyColors.icon),
      textTheme: TextTheme(
        headlineMedium: TextStyle(
            color: Colors.black87,
            fontFamily: 'CarterOne',
            fontWeight: FontWeight.w100,
            fontSize: 23),
      ),
      hintColor: Colors.black38,
      primaryColor: MyColors.white,
      canvasColor: Color.fromRGBO(186, 255, 240, 1),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
          color: MyColors.black,
        ),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(
        Icons.arrow_back_rounded,
        color: MyColors.black,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('BuildResults');
  }

  Widget _emptyContainer() {
    return Container(
      decoration: BoxDecoration(
        // color: Color.fromRGBO(186, 255, 240, 1),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color.fromRGBO(48, 164, 139, 1),
            Color.fromRGBO(68, 226, 192, 1),
            Color.fromRGBO(92, 255, 220, 1),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          Icons.movie_filter_rounded,
          size: 250,
          color: Colors.white70,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _emptyContainer();
    }

    final moviesprivider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: moviesprivider.searchMovie(query),
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => _MovieItems(movies[index]),
        );
      },
    );
  }
}

class _MovieItems extends StatelessWidget {
  final Movie movie;

  const _MovieItems(this.movie);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          padding: EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
            ),
            // gradient: LinearGradient(colors: [
            //   Color.fromRGBO(48, 164, 139, 1),
            //   Color.fromRGBO(68, 226, 192, 1),
            //   Color.fromRGBO(92, 255, 220, 1),
            // ])
          ),
          child: ListTile(
            leading: FadeInImage(
              placeholder: AssetImage('assets/movieLoad.gif'),
              image: NetworkImage(movie.fullBackdropPath),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            title: Text(
              movie.title,
              style: TextStyle(fontFamily: 'CarterOne'),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              movie.overview,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontFamily: 'AndadaPro'),
            ),
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
          ),
        ),
        Positioned(
          left: 89.5,
          // top: 5,
          bottom: -5,
          child: Icon(Icons.star, color: MyColors.white, size: 46),
        ),
        Positioned(
          left: 90,
          // top: 5,
          bottom: -5,
          child: Icon(Icons.star, color: Colors.amber, size: 45),
        ),
        Positioned(
          left: 106,
          // top: 5,
          bottom: 10,
          child: Text(
            '${movie.voteAverage}',
            style: TextStyle(fontSize: 9, fontFamily: 'CarterOne'),
          ),
        ),
      ],
    );
  }
}
