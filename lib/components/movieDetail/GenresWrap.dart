import 'package:flutter/material.dart';
import 'package:movie_app/model/Movie.dart';

class GenreWrap extends StatelessWidget {
  final Movie movie;

  GenreWrap({
    this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
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
    );
  }
}