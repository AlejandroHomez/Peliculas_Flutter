// To parse this JSON data, do
//
//     final topRateResponse = topRateResponseFromMap(jsonString);

import 'dart:convert';
import 'movie.dart';

class TopRateResponse {
  TopRateResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  factory TopRateResponse.fromJson(String str) =>
      TopRateResponse.fromMap(json.decode(str));

  factory TopRateResponse.fromMap(Map<String, dynamic> json) => TopRateResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
