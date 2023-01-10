import 'package:flutter/material.dart';
import 'package:peliculas_app/preferencias/preferencias_usuario.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/providers/series_provider.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:peliculas_app/themeData.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = PreferenciasUsurario();
  await pref.initPref();

  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => MoviesProvider(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_) => SeriesProvider(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_) => VideoEnlace(),
      )
    ], child: MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData(context),
      debugShowCheckedModeBanner: false,
      title: 'Peliculas App',
      initialRoute: 'inicio',
      routes: {
        'inicio': (_) => InicioPage(),
        'home': (_) => HomeScreen(),
        'details': (_) => DetailsScreen(),
        'series': (_) => SeriesPage(),
        'trailers': (_) => TrailersPage(),
        'actor': (_) => ActorScreen(),
        'favorites': (_) => FavoritesPage(),
        'video': (_) => VideoScreen(),
      },
    );
  }
}
