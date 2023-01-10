import 'dart:convert';

class Serie {
  Serie({
    this.backdropPath,
    this.genreIds,
    required this.id,
    required this.name,
    this.originCountry,
    this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  String? backdropPath;
  List<int>? genreIds;
  int id;
  String name;
  List<String>? originCountry;
  String? originalLanguage;
  String originalName;
  String overview;
  double popularity;
  String? posterPath;
  double voteAverage;
  int voteCount;

  get fullPosterImgSerie {
    if (this.posterPath != null)
      return 'https://image.tmdb.org/t/p/w500${this.posterPath}';

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  get fullBackdropPathSerie {
    if (this.backdropPath != null)
      return 'https://image.tmdb.org/t/p/w500${this.backdropPath}';

    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  factory Serie.fromJson(String str) => Serie.fromMap(json.decode(str));

  factory Serie.fromMap(Map<String, dynamic> json) => Serie(
        backdropPath:
            json["backdrop_path"] == null ? null : json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        name: json["name"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );
}
