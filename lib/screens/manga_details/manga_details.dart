import 'package:flutter/material.dart';
import 'package:manga_tracker/models/manga.dart';
import 'package:manga_tracker/shared/scaffold.dart';

class MangaDetails extends StatefulWidget {
  final MangaData mangaDetails;
  MangaDetails({@required this.mangaDetails});

  @override
  _MangaDetailsState createState() => _MangaDetailsState();
}

class _MangaDetailsState extends State<MangaDetails> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: widget.mangaDetails.title,
      actions: <Widget>[
        IconButton(
          icon: isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          onPressed: () => setState(() => isFavorite = !isFavorite),
        ),
      ],
      body: Container(
        child: Text('Manga Details'),
      ),
    );
  }
}
