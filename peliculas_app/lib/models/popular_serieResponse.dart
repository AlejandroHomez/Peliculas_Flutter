// To parse this JSON data, do
//
//     final popularSerieResponse = popularSerieResponseFromMap(jsonString);

import 'dart:convert';

import 'serie.dart';

class PopularSerieResponse {
  PopularSerieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Serie> results;
  int totalPages;
  int totalResults;

  factory PopularSerieResponse.fromJson(String str) =>
      PopularSerieResponse.fromMap(json.decode(str));

  factory PopularSerieResponse.fromMap(Map<String, dynamic> json) =>
      PopularSerieResponse(
        page: json["page"],
        results: List<Serie>.from(json["results"].map((x) => Serie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
