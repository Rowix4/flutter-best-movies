import 'package:flutter_test/flutter_test.dart';

import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/model/People.dart';
import 'package:movie_app/repository/MovieRepository.dart';
import 'package:movie_app/repository/PeopleRepository.dart';

void main() {
  test('People could be created', () {
    const peopleJson = {
      'id': 1,
      'name': 'James'
    };

    var people = People.fromJson(peopleJson, 'movie');

    expect(people.id, peopleJson['id']);
    expect(people.name, peopleJson['name']);

    print('People fromJson passed!');
  });

  test('Get movie peoples', () async {
    List<Movie> movies = await fetchBestMovies();

    List<People> peoples = await fetchMoviePeoples(movies[0]);

    expect(peoples.isEmpty, false);
    print('Get movie peoples passed!');
  });
}