import 'package:flutter/material.dart';

import 'peliculas_app.dart';

class AppRoutes {
  static const initialRoute = 'inicio';

  static final Map<String, Widget Function(BuildContext)> routes = {
    'inicio': (_) => InicioPage(),
    'home': (_) => HomeScreen(),
    'details': (_) => DetailsScreen(),
    'series': (_) => SeriesPage(),
    'trailers': (_) => TrailersPage(),
    'actor': (_) => ActorScreen(),
    'favorites': (_) => FavoritesPage(),
    'video': (_) => VideoScreen(),
  };
}
