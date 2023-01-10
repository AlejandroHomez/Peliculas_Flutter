import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsurario  {

  static final PreferenciasUsurario _instancia =
      new PreferenciasUsurario._internal();

  factory PreferenciasUsurario() {
    return _instancia;
  }

  PreferenciasUsurario._internal();

  late SharedPreferences _prefs;

  initPref() async {
    this._prefs = await SharedPreferences.getInstance();
  }
    
  get getMoviesFav {
    return _prefs.getStringList( 'movies' );
  }

  set movies(List<String> valor) {
    _prefs.setStringList('movies', valor);
  }
}
