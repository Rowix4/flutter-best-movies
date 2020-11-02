import 'package:flutter/material.dart';
import 'package:movie_app/model/Movie.dart';
import 'package:movie_app/screens/MovieDetail.dart';

class CardListView extends StatelessWidget {
  final Future<List<Movie>> movies;
  final double bottomPadding;

  const CardListView({
    this.movies,
    this.bottomPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Container(
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder<List<Movie>>(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Movie movie = snapshot.data[index];
                return GestureDetector(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 0, bottomPadding),
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
    ));
  }
}