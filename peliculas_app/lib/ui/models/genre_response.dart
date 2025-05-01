// To parse this JSON data, do
//
//     final genreResponse = genreResponseFromMap(jsonString);

import 'dart:convert';

class GenreResponse {
    GenreResponse({
    required this.genres,
  });

    List<Genre> genres;

    factory GenreResponse.fromJson(String str) =>
      GenreResponse.fromMap(json.decode(str));

    factory GenreResponse.fromMap(Map<String, dynamic> json) => GenreResponse(
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromMap(x))),
    );
}

class Genre {
    Genre({
    required this.id,
    required this.name,
  });

  int id;
  String name;

    factory Genre.fromJson(String str) => Genre.fromMap(json.decode(str));

    factory Genre.fromMap(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
    );
}
