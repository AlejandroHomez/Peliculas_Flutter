// To parse this JSON data, do
//
//     final videoResponse = videoResponseFromMap(jsonString);

import 'dart:convert';

class VideoResponse {
  VideoResponse({
    required this.id,
    this.results,
  });

  int id;
  List<Video>? results;

  factory VideoResponse.fromJson(String str) =>
      VideoResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory VideoResponse.fromMap(Map<String, dynamic> json) => VideoResponse(
        id: json["id"],
        results:
            List<Video>.from(json["results"].map((x) => Video.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "results": List<dynamic>.from(results!.map((x) => x.toMap())),
      };
}

class Video {
  Video({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    // this.publishedAt,
    this.id,
  });

  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  // DateTime? publishedAt;
  String? id;

  factory Video.fromJson(String str) => Video.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Video.fromMap(Map<String, dynamic> json) => Video(
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        // publishedAt: DateTime.parse(json["published_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "iso_639_1": iso6391,
        "iso_3166_1": iso31661,
        "name": name,
        "key": key,
        "site": site,
        "size": size,
        "type": type,
        "official": official,
        // "published_at": publishedAt.toString(),
        "id": id,
      };
}
