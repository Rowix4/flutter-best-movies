import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double topPadding;

  const TitleText({
    this.text,
    this.topPadding = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, topPadding, 10, 10),
            child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 27)
            )
        ));
  }
}