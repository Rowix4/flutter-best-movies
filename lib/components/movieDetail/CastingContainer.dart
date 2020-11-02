import 'package:flutter/material.dart';
import 'package:movie_app/model/People.dart';

class CastingContainer extends StatelessWidget {
  final Future<List<People>> peoples;

  CastingContainer({
    this.peoples,
  });

  @override
  Widget build(BuildContext context) {
    return Container(child: Padding(
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
    ));
  }
}