import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manga_tracker/models/manga.dart';
import 'package:manga_tracker/screens/home/manga_item.dart';
import 'package:manga_tracker/services/database.dart';
import 'package:manga_tracker/shared/loading.dart';

class MangaList extends StatelessWidget {
  final List<MangaData> mangaDataList;
  final String title;

  MangaList({@required this.mangaDataList, @required this.title});

  @override
  Widget build(BuildContext context) {
    // final mangas = Provider.of<List<Mangad>>(context) ?? [];

    return StreamBuilder<List<MangaData>>(
        stream: DatabaseService().mangas,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
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
