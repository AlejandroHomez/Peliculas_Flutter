import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/screens/screens.dart';

class ClasPeliculas extends StatelessWidget {
  final List<int> movieGenreID;
  final Movie movie;

  const ClasPeliculas(this.movieGenreID, this.movie);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // future: moviesProvider.getGenresMovies(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
      return Container(
          width: double.infinity,
          height: 25,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _listGenres(snapshot.data, context),
          ));
    });
  }

  List<Widget> _listGenres(List<dynamic>? datos, BuildContext context) {
    final List<Widget> opciones = [];

    datos?.forEach((name) {
      final temp = Row(
        children: [
          Text(name),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 4.0,
            ),
            child: ElevatedButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: MyColors.colorIcon,
                    radius: 10,
                    child: Text(
                      name['name'][0],
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    name['name'],
                    style: TextStyle(color: MyColors.colorText, fontSize: 12),
                  )
                ],
              ),
              onPressed: () {},
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
                  backgroundColor: MaterialStateProperty.all(Colors.black12),
                  elevation: MaterialStateProperty.all(0),
                  padding: MaterialStateProperty.all(EdgeInsets.all(5))),
            ),
          ),
          Icon(
            Icons.fiber_manual_record_outlined,
            size: 12,
            color: MyColors.colorItem,
          )
        ],
      );

      opciones..add(temp);
    });

    return opciones;
  }
}


  


// class _CrearCategorias extends StatelessWidget {

//   final Genre genre;
//   final Movie movie;

//   const _CrearCategorias(this.genre, this.movie);
//   @override
//   Widget build(BuildContext context) {

//     return Row(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 4.0,
//           ),
//           child: ElevatedButton(
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircleAvatar(
//                   backgroundColor: MyColors.colorIcon,
//                   radius: 10,
//                   child: Text(
//                     "${movie.genreIds}}"[0],
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 5,
//                 ),
//                 Text(
//                   "${movie.genreIds}",
//                   style: TextStyle(color: MyColors.colorText, fontSize: 12),
//                 )
//               ],
//             ),
//             onPressed: () {},
//             style: ButtonStyle(
//                 shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50))),
//                 backgroundColor: MaterialStateProperty.all(Colors.black12),
//                 elevation: MaterialStateProperty.all(0),
//                 padding: MaterialStateProperty.all(EdgeInsets.all(5))),
//           ),
//         ),
//         Icon(
//           Icons.fiber_manual_record_outlined,
//           size: 12,
//           color: MyColors.colorItem,
//         )
//       ],
//     );
//   }
// }