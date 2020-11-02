import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/model/People.dart';

const api = 'https://api.themoviedb.org/3/';
const apiKey = 'b463d9614e0a307b64893e2d73e327ee';

Future<List<People>> fetchMoviePeoples(Movie movie) async {
  final response =
  await http.get(api + movie.type + '/' + movie.id.toString() + '/credits?api_key=' + apiKey + '&language=fr-FR');

  if (response.statusCode == 200) {
    var body = jsonDecode(response.body);
    var results = body['cast'];

    List<People> peoples = [];

    for (var i = 0; i < 4; i++) {
      peoples.add(People.fromJson(results[i], 'tv'));
    }

    return peoples;
  } else {
    throw Exception('Failed to peoples for this movie.');
  }
}