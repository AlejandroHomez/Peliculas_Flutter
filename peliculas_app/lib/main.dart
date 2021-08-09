import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:peliculas_app/themeData.dart';
import 'package:provider/provider.dart';
 
void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider( ), lazy: false,)
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
      initialRoute: 'home',

      routes: {
        'home' : ( _ ) => HomeScreen(),
        'details' : ( _ ) => DetailsScreen(),
    
      },

      theme: themeData(context),
      themeMode: ThemeMode.dark,
        
      );
  }
}