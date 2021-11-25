// To parse this JSON data, do
//
//     final topRateSerieResponse = topRateSerieResponseFromMap(jsonString);

import 'dart:convert';
import 'serie.dart';

class TopRateSerieResponse {
  TopRateSerieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Serie> results;
  int totalPages;
  int totalResults;

  factory TopRateSerieResponse.fromJson(String str) =>
      TopRateSerieResponse.fromMap(json.decode(str));

  factory TopRateSerieResponse.fromMap(Map<String, dynamic> json) =>
      TopRateSerieResponse(
        page: json["page"],
        results: List<Serie>.from(json["results"].map((x) => Serie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}
