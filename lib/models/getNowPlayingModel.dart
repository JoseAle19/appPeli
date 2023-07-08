// ignore_for_file: file_names

import 'dart:convert';

NowPlayinMovies nowPlayinMoviesFromJson(String str) =>
    NowPlayinMovies.fromJson(json.decode(str));

class NowPlayinMovies {
  NowPlayinMovies({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  final int page;
  final List<Result> results;
  final int totalPages;
  final int totalResults;

  factory NowPlayinMovies.fromJson(Map<String, dynamic> json) =>
      NowPlayinMovies(
        page: json["page"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });

  final DateTime maximum;
  final DateTime minimum;

  Map<String, dynamic> toJson() => {
        "maximum":
            "${maximum.year.toString().padLeft(4, '0')}-${maximum.month.toString().padLeft(2, '0')}-${maximum.day.toString().padLeft(2, '0')}",
        "minimum":
            "${minimum.year.toString().padLeft(4, '0')}-${minimum.month.toString().padLeft(2, '0')}-${minimum.day.toString().padLeft(2, '0')}",
      };
}

class Result {
  Result({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final OriginalLanguage? originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  get addPosterPath {
    // ignore: unnecessary_null_comparison
    if (posterPath != null) {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
    return 'https://us.123rf.com/450wm/jovanas/jovanas1810/jovanas181001129/110959539-no-record-video-sign-no-shoot-video-sign.jpg';
  }

  get addbackdropPath {
    // ignore: unnecessary_null_comparison
    if (posterPath != null) {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
    return 'https://us.123rf.com/450wm/jovanas/jovanas1810/jovanas181001129/110959539-no-record-video-sign-no-shoot-video-sign.jpg';
  }

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        adult: json["adult"],
        backdropPath: json["backdrop_path"] ?? '',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage:
            originalLanguageValues.map[json["original_language"]] ??
                OriginalLanguage.EN,
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"]?.toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"] ?? 'Sin votaciones',
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
      );
}

// ignore: constant_identifier_names
enum OriginalLanguage { EN, ES, RU }

final originalLanguageValues = EnumValues({
  "en": OriginalLanguage.EN,
  "es": OriginalLanguage.ES,
  "ru": OriginalLanguage.RU
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
