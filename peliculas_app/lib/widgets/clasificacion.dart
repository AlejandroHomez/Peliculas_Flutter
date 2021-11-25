import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/models/genre_response.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/widgets/myColors.dart';
import 'package:provider/provider.dart';

class ClasPeliculas extends StatelessWidget {
  
  final List<int> genreMovie;

  const ClasPeliculas(this.genreMovie);

  @override
  Widget build(BuildContext context) {
    int lengthGenre = genreMovie.length;
    int primerDato = genreMovie[0];
    return Container(
        padding: EdgeInsets.symmetric( vertical: 6) ,
        width: double.infinity,
        height: 40,
        // color: Colors.red,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: lengthGenre,
            itemBuilder: (_, int index) =>
                CrearCategorias(genreMovie[index], lengthGenre, primerDato)));
  }
}

class CrearCategorias extends StatelessWidget {

  final int genreID;
  final int lengthGenre;
  final int primerDato;

  const CrearCategorias(this.genreID, this.lengthGenre, this.primerDato);
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: moviesProvider.getGenreMovies(genreID),
        builder: (_, AsyncSnapshot<List<Genre>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: CupertinoActivityIndicator(
                radius: 15,
              ),
            );
          }

          final List<Genre> genreName = snapshot.data!;

          for (var i = 0; i < genreName.length; i++) {
            if (genreID == genreName[i].id) {
              String name = genreName[i].name;

              return Row(
                children: [
                  Container(child: _iconoo(context, genreName[i].id)),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: ElevatedButton(
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: MyColors.colorIcon,
                            radius: 10,
                            child: Text(
                              name[0],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                                color: MyColors.colorText, fontSize: 12),
                          )
                        ],
                      ),
                      onPressed: () {},

                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey.shade200),
                          elevation: MaterialStateProperty.all(0),
                          padding:
                              MaterialStateProperty.all(EdgeInsets.all(5))),
                    ),
                  ),
                ],
              );
            }
          }

          return Text('no hay datos');
        });
  }

  Widget _iconoo(BuildContext context, int posision) {

  if (posision != primerDato) {
      return Icon(
        Icons.fiber_manual_record_outlined,
        size: 12,
        color: MyColors.colorItem,
      );
    } else {
      return Container();
    }
}

}

