import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/model/Movie.dart';

const api = 'https://api.themoviedb.org/3/';
const apiKey = 'b463d9614e0a307b64893e2d73e327ee';

Future<List<Movie>> fetchPopularMovies() async {
  final response =
  await http.get(api + 'movie/popular?api_key=' + apiKey + '&language=fr-FR&page=1');

  if (response.statusCode == 200) {
     var body = jsonDecode(response.body);
     var results = body['results'];

     List<Movie> movies = [];

     results.forEach((element) => movies.add(Movie.fromJson(element, 'movie')));

     return movies;
  } else {
    throw Exception('Failed to load popular movies');
  }
}

Future<List<Movie>> fetchPopularTV() async {
  final response =
  await http.get('https://api.themoviedb.org/3/tv/popular?api_key=b463d9614e0a307b64893e2d73e327ee&language=fr-FR&page=1');

  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    var results = body['results'];

    List<Movie> tvShows = [];

    results.forEach((element) => tvShows.add(Movie.fromJson(element, 'tv')));

    return tvShows;
  } else {
    throw Exception('Failed to load popular TV shows');
  }
}

Future<List<Movie>> fetchBestMovies() async {
  final response =
  await http.get(api + 'movie/top_rated?api_key=' + apiKey + '&language=fr-FR&page=1');

  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    var results = body['results'];

    List<Movie> movies = [];

    results.forEach((element) => movies.add(Movie.fromJson(element, 'movie')));

    return movies;
  } else {
    throw Exception('Failed to load popular movies');
  }
}

Future<Movie> getMovieDetails(Movie movie) async {
  final response =
  await http.get(api + movie.type + '/' + movie.id.toString() + '?api_key=b463d9614e0a307b64893e2d73e327ee&language=fr-FR');

  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);

    return Movie.fromJson(body, movie.type);
  } else {
    throw Exception('Failed to load popular movies');
  }
}

