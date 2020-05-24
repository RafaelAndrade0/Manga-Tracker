import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:manga_tracker/models/manga.dart';
import 'package:manga_tracker/screens/home/manga_item.dart';
import 'package:manga_tracker/services/database.dart';

class MangaList extends StatelessWidget {
  final String title;

  MangaList({@required this.title});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MangaData>>(
        stream: DatabaseService().mangas,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SpinKitRotatingCircle(
              color: Colors.orangeAccent,
              size: 50.0,
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 5.0,
                ),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              Container(
                // margin: EdgeInsets.symmetric(vertical: 10.0),
                height: 200.0,
                child: ListView(
                  // This next line does the trick.
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    for (var data in snapshot.data)
                      MangaItem(
                        mangaData: data,
                      )
                  ],
                ),
              ),
            ],
          );
        });
  }
}
