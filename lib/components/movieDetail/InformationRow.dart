import 'package:flutter/material.dart';
import 'package:movie_app/model/Movie.dart';

class InformationRow extends StatelessWidget {
  final Movie movie;

  InformationRow({
    this.movie,
  });

  Widget separator() {
    return Column(
      children: [
        Padding(padding: const EdgeInsets.only(right: 30)),
        Text('-', style: new TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
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
    ]);
  }
}