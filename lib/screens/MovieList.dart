import 'package:flutter/material.dart';

import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/repository/MovieRepository.dart';

import 'MovieDetail.dart';

class MovieList extends StatefulWidget {
  MovieList({Key key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  Future<List<Movie>> futureMovies;
  Future<List<Movie>> futureBestMovies;
  Future<List<Movie>> futureTvShows;

  @override
  void initState() {
    super.initState();
    futureMovies = fetchPopularMovies();
    futureTvShows = fetchPopularTV();
    futureBestMovies = fetchBestMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 40, 10, 10),
                  child: Text(
                      "Films populaires",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 27)
                  )
              )),
          Expanded(child: Container(
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<List<Movie>>(
              future: futureMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Movie movie = snapshot.data[index];
                      return GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Image.network('https://image.tmdb.org/t/p/w500/' + movie.posterPath),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MovieDetail(movie: movie,)),
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  print("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return Center(child: CircularProgressIndicator());
              },
            ),
          )),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 10, 10),
                  child: Text(
                      "Séries populaires",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 27)
                  )
              )),
          Expanded(child: Container(
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<List<Movie>>(
              future: futureTvShows,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Movie tvShow = snapshot.data[index];
                      return GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                          child: Image.network('https://image.tmdb.org/t/p/w500/' + tvShow.posterPath),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MovieDetail(movie: tvShow,)),
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  print("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return Center(child: CircularProgressIndicator());
              },
            ),
          )),
          Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 10, 10),
                  child: Text(
                      "Films les mieux notés",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 27)
                  )
              )),
          Expanded(child: Container(
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<List<Movie>>(
              future: futureBestMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Movie movie = snapshot.data[index];
                      return GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 30),
                          child: Image.network('https://image.tmdb.org/t/p/w500/' + movie.posterPath),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MovieDetail(movie: movie,)),
                          );
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  print("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return Center(child: CircularProgressIndicator());
              },
            ),
          )),
        ],
      ),
    );
  }
}
