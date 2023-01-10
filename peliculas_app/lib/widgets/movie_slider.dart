import 'package:flutter/material.dart';
import 'package:peliculas_app/models/movie.dart';
import 'package:peliculas_app/tokens/tokens.dart';

class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
    Key? key,
    required this.movies,
    required this.onNextPage,
    this.title,
  }) : super(key: key);

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        this.widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (this.widget.title != null)
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 5),
              child: Title(
                  color: Colors.red,
                  child: Text(
                    widget.title!,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'CarterOne',
                        color: Colors.black87),
                  )),
            ),
          Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.movies.length,
                  itemBuilder: (_, int index) =>
                      MovieHorizontal(widget.movies[index]))),
        ],
      ),
    );
  }
}

class MovieHorizontal extends StatelessWidget {
  final Movie movie;

  const MovieHorizontal(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 160,
      margin: EdgeInsets.only(bottom: 5, left: 10, right: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: FadeInImage(
                placeholder: AssetImage('assets/movieLoad.gif'),
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.cover,
                width: 130,
                height: 160,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: MyColors.colorText,
                fontSize: 12,
                fontFamily: 'AndadaPro'),
          ),
          Text(
            "Calificacion:  ${movie.voteAverage}",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.cyan, fontSize: 11, fontFamily: 'CarterOne'),
          )
        ],
      ),
    );
  }
}
