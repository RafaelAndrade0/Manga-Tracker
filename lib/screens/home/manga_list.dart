import 'package:flutter/material.dart';
import 'package:manga_tracker/models/manga.dart';
import 'package:manga_tracker/screens/home/manga_item.dart';

class MangaList extends StatelessWidget {
  final List<MangaData> mangaDataList;
  final String title;

  MangaList({@required this.mangaDataList, @required this.title});

  @override
  Widget build(BuildContext context) {
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
              for (var data in mangaDataList)
                MangaItem(
                  mangaData: data,
                )
            ],
          ),
        ),
      ],
    );
  }
}
