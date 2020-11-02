import 'package:flutter/material.dart';

import 'package:movie_app/components/movieList/CardListView.dart';
import 'package:movie_app/components/movieList/TitleText.dart';

import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/repository/MovieRepository.dart';

class MovieList extends StatefulWidget {
  MovieList({Key key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  Future<List<Movie>> popularMovies;
  Future<List<Movie>> bestMovies;
  Future<List<Movie>> popularTvShows;

  @override
  void initState() {
    super.initState();
    popularMovies = fetchPopularMovies();
    bestMovies = fetchPopularTV();
    popularTvShows = fetchBestMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          TitleText(text: "Films populaires", topPadding: 40),
          CardListView(movies: popularMovies),
          TitleText(text: "Séries populaires"),
          CardListView(movies: popularTvShows),
          TitleText(text: "Films les mieux notés"),
          CardListView(movies: bestMovies, bottomPadding: 25)
        ],
      ),
    );
  }
}
