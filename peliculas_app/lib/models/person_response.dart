// To parse this JSON data, do
//
//     final personResponse = personResponseFromMap(jsonString);

import 'dart:convert';

class PersonResponse {
    PersonResponse({
       this.adult,
       this.alsoKnownAs,
       this.biography,
       this.birthday,
       this.deathday,
       this.gender,
       this.homepage,
       required this.id,
       this.imdbId,
       this.knownForDepartment,
       required this.name,
       this.placeOfBirth,
       this.popularity,
       this.profilePath,
    });

    bool? adult;
    List<String>? alsoKnownAs;
    String? biography;
    DateTime? birthday;
    dynamic? deathday;
    int? gender;
    dynamic homepage;
    int id;
    String? imdbId;
    String? knownForDepartment;
    String name;
    String? placeOfBirth;
    double? popularity;
    String? profilePath;
    
    factory PersonResponse.fromJson(String str) => PersonResponse.fromMap(json.decode(str));

    factory PersonResponse.fromMap(Map<String, dynamic> json) => PersonResponse(
        adult: json["adult"],
        alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
        biography: json["biography"],
        birthday: DateTime.parse(json["birthday"]),
        deathday: json["deathday"],
        gender: json["gender"],
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        placeOfBirth: json["place_of_birth"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
    );
}
