import 'package:flutter/material.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:peliculas_app/serach/search_delegate.dart';

AppBar myAppbar (BuildContext context) {

return AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: Icon(Icons.clear_all, size: 40, color: MyColors.colorIcon),
            onPressed: () {}
            
            ),
        ),
        
        title: Text('Peliculas en Cine'),
        actions: [
          Padding(
            padding: EdgeInsets.all(7.0),
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: MyColors.colorIcon,
              onPressed: ()  => showSearch(context: context, delegate: MovieSearchDelegate() ),
              child: Icon(Icons.search_outlined)
              ),
          )

        ],
      );

}