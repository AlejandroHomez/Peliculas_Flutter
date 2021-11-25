
import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/providers/serie_provider.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:peliculas_app/themeData.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  
  runApp(AppState());
  
  }

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (_) => MoviesProvider(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_) => SeriesProvider(),
        lazy: false,
      ),
      ChangeNotifierProvider(
        create: (_) => VideoEnlace(),)
       ],
       child: MyApp()
      );
  }
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas App',
      initialRoute: 'inicio',

      routes: {
        
        'inicio': (_) => InicioPage(),

        'home'    : ( _ ) => HomeScreen(),
        'details' : ( _ ) => DetailsScreen(),
        'series'  : ( _ ) => SeriesPage(),
        'trailers': ( _ ) => TrailersPage(),
        'actor'   : ( _ ) => ActorScreen(),

        'video': (_) => VideoScreen(),
    
      },

      theme: themeData(context),
      themeMode: ThemeMode.dark,
        
      );
  }
}