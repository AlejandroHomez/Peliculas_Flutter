import 'package:flutter/cupertino.dart';
import 'package:peliculas_app/models/popular_serieResponse.dart';
import 'package:peliculas_app/models/serie.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/topRated_Series.dart';

class SeriesProvider extends ChangeNotifier {
  String _apiKey = '5e17a1ad7031a91705fb9a44f64eb3d5';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Serie> topRatedSerie = [];
  List<Serie> popularSerie = [];
  List<Serie> popularSerie2 = [];

  int popularPage = 0;
  int topRatedPage = 0;

  SeriesProvider() {
    print('Movies provider series inicializado');
    this.getTopRatedSeries();
    this.getPopularSeries();
    this.getPopularSeries2();
  }

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(this._baseUrl, endpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);
    print(response);

    return response.body;
  }

  getTopRatedSeries() async {
    topRatedPage++;

    final jsonData = await this._getJsonData('3/tv/top_rated', topRatedPage);
    final topRatedResponse = TopRateSerieResponse.fromJson(jsonData);
    topRatedSerie = topRatedResponse.results;

    notifyListeners();
  }

  getPopularSeries() async {
    popularPage++;

    final jsonData = await this._getJsonData('3/tv/popular', popularPage);
    final popularSerieResponse = PopularSerieResponse.fromJson(jsonData);
    popularSerie = popularSerieResponse.results;

    notifyListeners();
  }

  getPopularSeries2() async {
    final jsonData = await this._getJsonData('3/tv/popular', 2);
    final popularSerieResponse2 = PopularSerieResponse.fromJson(jsonData);
    popularSerie2 = popularSerieResponse2.results;

    notifyListeners();
  }

}
