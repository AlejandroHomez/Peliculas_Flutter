import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/models/person_response.dart';
import 'package:peliculas_app/models/search_response.dart';
import 'package:peliculas_app/models/topRate_response.dart';
import 'package:peliculas_app/models/upcoming_response.dart';
import 'package:peliculas_app/models/video_movie_response.dart';
import 'package:peliculas_app/preferencias/preferencias_usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = '5e17a1ad7031a91705fb9a44f64eb3d5';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  final preferencias = PreferenciasUsurario();

  late PersonResponse detallesActor;
  List<Movie> onDisplayMovie = [];
  List<Movie> popularMovies = [];
  List<Movie> popularMoviesVideo = [];
  List<Movie> upcomingMovies = [];
  List<Movie> topRateMovies = [];
  List<String> userPreferencesList = [];

  List<Movie> favoriteMovies = [];
  bool guardandoMovie = false;
  bool eliminarMovie = false;

  int length = 0;

  Map<int, List<Cast>> movieCast = {};
  Map<int, List<Genre>> movieGenre = {};
  Map<int, List<Video>> videoMovie = {};

  int _upcomingPage = 0;
  int _popularPage = 0;
  int _popularPageVideo = 0;
  int _topRatedPage = 0;

  MoviesProvider() {
    print('Movies provider inicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
    this.getPopularMoviesVideo();
    this.getUpcomingMovies();
    this.getTopRatioMovies();
    this.getUserPreferences();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(this._baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);

    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovie = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;

    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  getPopularMoviesVideo() async {
    _popularPageVideo++;

    if (popularMoviesVideo.length == length && popularMoviesVideo.length > 0) {
      notifyListeners();
      return popularMoviesVideo;
    }

    for (var i = 0; i < 5; i++) {
      final jsonData1 =
          await this._getJsonData('3/movie/popular', _popularPageVideo);

      final popularResponse1 = PopularResponse.fromJson(jsonData1);

      for (var i = 0; i < popularResponse1.results.length; i++) {
        final int movieId1 = popularResponse1.results[i].id;
        final dataJson1 = await this._getJsonData('3/movie/$movieId1/videos');
        final movieResponse1 = VideoResponse.fromJson(dataJson1);

        if (movieResponse1.results!.isNotEmpty) {
          popularMoviesVideo.add(popularResponse1.results[i]);
        }
      }
      _popularPageVideo++;
    }

    notifyListeners();
    length = popularMoviesVideo.length;
    print(popularMoviesVideo.length);
  }

  Future<List<Genre>> getGenreMovies(int genreId) async {
    if (movieGenre.containsKey(genreId)) return movieGenre[genreId]!;

    final jsonData = await this._getJsonData('3/genre/movie/list');
    final genreResponse = GenreResponse.fromJson(jsonData);

    movieGenre[genreId] = genreResponse.genres;
    return genreResponse.genres;
  }

  getUpcomingMovies() async {
    _upcomingPage++;

    final jsonData = await this._getJsonData('3/movie/upcoming', _upcomingPage);
    final upcomingResponse = UpcomingResponse.fromJson(jsonData);

    upcomingMovies = [...upcomingMovies, ...upcomingResponse.results];
    notifyListeners();
  }

  getTopRatioMovies() async {
    _topRatedPage++;

    final jsonData =
        await this._getJsonData('3/movie/top_rated', _topRatedPage);
    final topRatedResponse = TopRateResponse.fromJson(jsonData);

    topRateMovies = [...topRateMovies, ...topRatedResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (movieCast.containsKey(movieId)) return movieCast[movieId]!;

    final jsonData =
        await this._getJsonData('3/movie/$movieId/credits', _popularPage);
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    movieCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<Video> getVideoMovie(int movieId) async {
    final jsonData = await this._getJsonData('3/movie/$movieId/videos');
    final movieResponse = VideoResponse.fromJson(jsonData);

    videoMovie[movieId] = movieResponse.results!;

    if (movieResponse.results!.isNotEmpty) {
      return movieResponse.results![0];
    }
    ;

    Video vid = Video(id: '000');
    return vid;
  }

//Buscar

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(this._baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

//Actores

  Future<PersonResponse> getActoresMovie(int idActor) async {
    final url = Uri.https(this._baseUrl, '3/person/$idActor',
        {'api_key': _apiKey, 'language': _language});

    final responseActor = await http.get(url);

    final actorResponse = PersonResponse.fromJson(responseActor.body);

    notifyListeners();
    return actorResponse;
  }

//Favoritas

  Future<List<Movie>> getFavoriteMovies(Movie movie) async {
    guardandoMovie = false;
    favoriteMovies.add(movie);

    setUserPreferences(favoriteMovies);

    guardandoMovie = true;
    notifyListeners();
    return favoriteMovies;
  }

  eliminarFavoritos(Movie movie) async {
    favoriteMovies.remove(movie);
    setUserPreferences(favoriteMovies);
    notifyListeners();
  }

  setUserPreferences(List<Movie> lista) async {
    userPreferencesList.clear();

    for (var i = 0; i < lista.length; i++) {
      String item = lista[i].id.toString();
      userPreferencesList.add(item);
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList('movies', userPreferencesList);

    notifyListeners();
  }

  getUserPreferences() async {
    List<String> listaString = [];
    listaString =
        preferencias.getMoviesFav != null ? preferencias.getMoviesFav : [];
    List<int> listaIds = listaString.map(int.parse).toList();

    favoriteMovies.clear();

    await getPopularMovies();
    await getTopRatioMovies();
    await getUpcomingMovies();
    await getOnDisplayMovies();

    final int dato = listaIds.length - 1;
    int contador = 0;
    int anterior = 0;

    while (contador <= dato) {
      if (anterior == contador && contador > 0) {
        await getPopularMovies();
        await getTopRatioMovies();
        await getUpcomingMovies();
        await getOnDisplayMovies();
      }

      bool encontrado = false;
      //Popular
      popu:
      for (var i = 0; i < popularMovies.length && encontrado; i++) {
        if (popularMovies[i].id == listaIds[contador] &&
            favoriteMovies.length <= dato) {
          favoriteMovies.add(popularMovies[i]);
          encontrado = true;
          anterior = contador;
          contador++;
          break popu;
        }
      }

      //topRate
      top:
      if (!encontrado) {
        for (var i = 0; i < topRateMovies.length; i++) {
          if (topRateMovies[i].id == listaIds[contador] &&
              favoriteMovies.length <= dato) {
            favoriteMovies.add(topRateMovies[i]);
            encontrado = true;
            anterior = contador;
            contador++;
            break top;
          }
        }
      }

      //upcom
      up:
      if (!encontrado) {
        for (var i = 0; i < upcomingMovies.length; i++) {
          if (upcomingMovies[i].id == listaIds[contador] &&
              favoriteMovies.length <= dato) {
            favoriteMovies.add(upcomingMovies[i]);
            encontrado = true;
            anterior = contador;
            contador++;
            break up;
          }
        }
      } //upcom

      //diplay
      dis:
      if (!encontrado) {
        for (var i = 0; i < onDisplayMovie.length; i++) {
          if (onDisplayMovie[i].id == listaIds[contador] &&
              favoriteMovies.length <= dato) {
            favoriteMovies.add(onDisplayMovie[i]);
            encontrado = true;
            anterior = contador;
            contador++;
            break dis;
          }
        }
      } //diplay

      if (!encontrado) {
        anterior = contador;
        contador++;
      }
    } // while
    notifyListeners();
    return favoriteMovies;
  }
}

class VideoEnlace extends ChangeNotifier {
  String _key = '';

  String get key => _key;

  set setKey(String value) {
    _key = value;
  }
}
