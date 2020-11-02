import 'package:flutter/material.dart';
import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/repository/MovieRepository.dart';
import 'package:movie_app/repository/PeopleRepository.dart';

import 'model/People.dart';

class MovieDetail extends StatefulWidget {
  MovieDetail({Key key, this.movie}) : super(key: key);

  final Movie movie;

  @override
  _MovieDetailState createState() => _MovieDetailState(movie);
}

class _MovieDetailState extends State<MovieDetail> {
  Movie movie;

  _MovieDetailState(Movie movie) {
    this.movie = movie;
  }

  Future<Movie> movieDetails;
  Future<List<People>> peoples;

  @override
  void initState() {
    super.initState();
    movieDetails = getMovieDetails(movie);
    peoples = fetchMoviePeoples(movie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height / 2,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              title: Text(movie.title ?? ''),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                      'https://image.tmdb.org/t/p/w500/' + movie.posterPath,
                      fit: BoxFit.cover
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.0, 0.9),
                        end: Alignment(0.0, 0.0),
                        colors: <Color>[
                          Colors.black,
                          Color(0x00000000),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
                FutureBuilder<Movie>(
                  future: movieDetails,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Movie movie = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Padding(padding: const EdgeInsets.fromLTRB(10, 10, 10, 10)),
                            Column(
                                children: [
                                  Padding(padding: const EdgeInsets.only(right: 30)),
                                  Text('15+', style: new TextStyle(color: Colors.white, fontSize: 14)),
                                ]
                            ),
                            separator(),
                            Column(
                              children: [
                                Padding(padding: const EdgeInsets.only(right: 30)),
                                Text(movie.releaseDate.substring(0,4) ?? '', style: new TextStyle(color: Colors.white, fontSize: 14)),
                              ],
                            ),
                            separator(),
                            Column(
                              children: [
                                Row(children: [
                                  Icon(Icons.star, color: Colors.yellow),
                                  Text(' ' + movie.rate ?? '0', style: new TextStyle(color: Colors.white, fontSize: 14)),
                                ])
                              ],
                            ),
                          ]),
                          Wrap(
                            children: <Widget>[
                              for(var genre in movie.genres ) Container(
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Text(
                                    genre['name'],
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0)),
                              ),
                            ],
                          ),
                          Container(child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 25, 10, 10),
                              child: Wrap(
                                children: [
                                  Text('Casting : ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                  FutureBuilder<List<People>>(
                                    future: peoples,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Wrap(
                                          children: snapshot.data.map((e) => Text(e.name + ', ', style: TextStyle(color: Colors.white))).toList()
                                        );
                                      } else if (snapshot.hasError) {
                                        print("${snapshot.error}");
                                      }

                                      // By default, show a loading spinner.
                                      return Center(child: CircularProgressIndicator());
                                    },
                                  ),
                                ],
                              )
                          )),
                          Container(child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                              child: Text(
                                  "Sommaire",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
                              )
                          )),
                          Container(child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                              child: Text(
                                movie.overview ?? '',
                                style: TextStyle(color: Colors.white), textAlign: TextAlign.justify,
                              )
                          )),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      print("${snapshot.error}");
                    }

                    // By default, show a loading spinner.
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ])
          )
        ],
      ),
    );
  }

  Widget separator()
  {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.only(right: 30)),
        Text('-', style: new TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}