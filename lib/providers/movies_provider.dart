// ignore: unused_import
import 'dart:convert';

import 'package:aplicacion_peliculas/models/get_actors_model.dart';
import 'package:aplicacion_peliculas/models/getNowPlayingModel.dart';
// import 'package:aplicacion_peliculas/models/getPopulaMoviesModel.dart';
// import 'package:aplicacion_peliculas/models/getTopRatedMovies.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _basUrl = 'api.themoviedb.org';
  final String _apiKey = '4669493131e3f81d082ad08f06122caf';
  final String _language = 'es-ES';
  List<Result> onDisplayMovies = [];
  List<Result> popularMovies = [];
  List<Result> topRatedMovies = [];
  int nextPage = 0;
  Map<int, List<Cast>> moviesCast = {};

  MoviesProvider() {
    getOnDisplayMOvies();
    getPopularMovies();
    getTopRatedMovies();
  }

  Future<String> requestEndpoint(String endPoint, {int page = 1}) async {
    var url = Uri.https(_basUrl, '3/movie/$endPoint',
        {"api_key": _apiKey, "language": _language, "page": '$page'});

    final res = await http.get(url);
    return res.body;
  }

  getOnDisplayMOvies() async {
    final decodeData =
        nowPlayinMoviesFromJson(await requestEndpoint('now_playing', page: 1));
    onDisplayMovies = decodeData.results;

    notifyListeners();
  }

  getPopularMovies() async {
    nextPage++;
    final decodeData = nowPlayinMoviesFromJson(
        await requestEndpoint('popular', page: nextPage));
    popularMovies = [...popularMovies, ...decodeData.results];
    notifyListeners();
  }

  getTopRatedMovies() async {
    nextPage++;
    final decodeData = nowPlayinMoviesFromJson(
        await requestEndpoint('top_rated', page: nextPage));
    topRatedMovies = [...topRatedMovies, ...decodeData.results];
    notifyListeners();
  }

// url https://api.themoviedb.org/3/movie/271969/credits?api_key=4669493131e3f81d082ad08f06122caf&language=es-ES
  Future<List<Cast>> getActorsMovie(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final decodeData =
        modelActorsFromJson(await requestEndpoint('$movieId/credits'));
    print(' pelicula $movieId ');
    moviesCast[movieId] = decodeData.cast;
    return decodeData.cast;
  }
}
