import 'dart:convert';

ModelActors modelActorsFromJson(String str) =>
    ModelActors.fromJson(json.decode(str));

String modelActorsToJson(ModelActors data) => json.encode(data.toJson());

class ModelActors {
  ModelActors({
    required this.id,
    required this.cast,
    required this.crew,
  });

  final int id;
  final List<Cast> cast;
  final List<Cast> crew;

  factory ModelActors.fromJson(Map<String, dynamic> json) => ModelActors(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cast": List<dynamic>.from(cast.map((x) => x.toJson())),
        "crew": List<dynamic>.from(crew.map((x) => x.toJson())),
      };
}

class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    required this.creditId,
    this.order,
    this.department,
    this.job,
  });

  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int? castId;
  final String? character;
  final String creditId;
  final int? order;
  final String? department;
  final String? job;

  get addPosterPath {
    // ignore: unnecessary_null_comparison
    if (profilePath != null) {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
    return 'https://us.123rf.com/450wm/jovanas/jovanas1810/jovanas181001129/110959539-no-record-video-sign-no-shoot-video-sign.jpg';
  }

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"],
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "gender": gender,
        "id": id,
        "known_for_department": knownForDepartment,
        "name": name,
        "original_name": originalName,
        "popularity": popularity,
        "profile_path": profilePath,
        "cast_id": castId,
        "character": character,
        "credit_id": creditId,
        "order": order,
        "department": department,
        "job": job,
      };
}
