import 'package:flutter/material.dart';

import 'package:movie_app/components/movieDetail/GenresWrap.dart';
import 'package:movie_app/components/movieDetail/InformationRow.dart';
import 'package:movie_app/components/movieDetail/CastingContainer.dart';
import 'package:movie_app/components/movieDetail/TextContainer.dart';

import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/model/People.dart';

import 'package:movie_app/repository/MovieRepository.dart';
import 'package:movie_app/repository/PeopleRepository.dart';

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
                          InformationRow(movie: movie),
                          GenreWrap(movie: movie),
                          CastingContainer(peoples: peoples),
                          TextContainer(text: "Sommaire"),
                          TextContainer(text: movie.overview, isBold: false,)
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


}