import 'package:flutter/material.dart';
import 'package:manga_tracker/models/manga.dart';
import 'package:manga_tracker/screens/manga_details/manga_details.dart';

class MangaItem extends StatelessWidget {
  final MangaData mangaData;

  MangaItem({@required this.mangaData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 2.5),
      width: 150.0,
      child: Stack(
        children: <Widget>[
          Container(
            width: 250,
            height: 250,
            child: Image.network(
              mangaData.url,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black.withAlpha(0),
                  Colors.black12,
                  Colors.black45,
                  Colors.black87
                ],
              ),
            ),
            child: Text(
              mangaData.title ?? 'Title',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Positioned.fill(
              child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MangaDetails(
                      mangaDetails: mangaData,
                    ),
                  ),
                )
              },
            ),
          ))
        ],
      ),
    );
  }
}
