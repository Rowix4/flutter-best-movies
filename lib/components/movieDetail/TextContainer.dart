import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String text;
  final bool isBold;

  const TextContainer({
    this.text,
    this.isBold = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Text(
            text ?? '',
            style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: Colors.white)
        )
    ));
  }
}