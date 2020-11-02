import 'package:flutter_test/flutter_test.dart';

import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/repository/MovieRepository.dart';

void main() {
  test('Movie could be created', () {
    const movieJson = {
      'id': 1,
      'title': 'Test movie',
      'genres': ['genre1'],
      'poster_path': 'path',
      'type': 'movie',
      'release_date': 'date',
      'overview': 'overview',
      'vote_average': '5',
    };

    var movie = Movie.fromJson(movieJson, 'movie');

    expect(movie.id, movieJson['id']);
    expect(movie.title, movieJson['title']);
    expect(movie.genres, movieJson['genres']);
    expect(movie.posterPath, movieJson['poster_path']);
    expect(movie.type, movieJson['type']);
    expect(movie.releaseDate, movieJson['release_date']);
    expect(movie.overview, movieJson['overview']);
    expect(movie.rate, movieJson['vote_average']);

    print('Movie fromJson passed!');
  });

  test('Get popular movies and get movie details', () async {
    List<Movie> popularMovies = await fetchPopularMovies();

    expect(popularMovies.isEmpty, false);
    print('Get popular movies passed!');

    Movie movie = await getMovieDetails(popularMovies[0]);

    expect(movie.id, isNot(null));
    print('Get movie details passed!');
  });

  test('Get best movies', () async {
    List<Movie> bestMovies = await fetchBestMovies();

    expect(bestMovies.isEmpty, false);
    print('Get best movies passed!');
  });

  test('Get popular TV shows', () async {
    List<Movie> popularTv = await fetchPopularTV();

    expect(popularTv.isEmpty, false);
    print('Get popular tv shows passed!');
  });
}