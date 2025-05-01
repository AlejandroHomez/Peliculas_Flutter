import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'peliculas_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pref = PreferenciasUsurario();
  await pref.initPref();
  // MobileAds.instance.initialize();
  await dotenv.load(fileName: "assets/.env");
  runApp(
    AppState(),
  );
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
          create: (_) => VideoEnlace(),
        )
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: themeData(context),
        debugShowCheckedModeBanner: false,
        title: 'Peliculas App',
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes);
  }
}
