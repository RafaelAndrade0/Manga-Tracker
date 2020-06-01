import 'package:flutter/material.dart';
import 'package:manga_tracker/models/manga.dart';
import 'package:manga_tracker/screens/home/manga_item.dart';

class Favorites extends StatefulWidget {
  Favorites({Key key}) : super(key: key);
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      // Generate 100 widgets that display their index in the List.
      children: <Widget>[
        MangaItem(
          mangaData: MangaData(
              url:
                  'https://images-na.ssl-images-amazon.com/images/I/91oTqmxq9cL.jpg',
              title: 'Naruto'),
        ),
        MangaItem(
          mangaData: MangaData(
              url:
                  'https://images-na.ssl-images-amazon.com/images/I/91oTqmxq9cL.jpg',
              title: 'Naruto'),
        ),
        MangaItem(
          mangaData: MangaData(
              url:
                  'https://images-na.ssl-images-amazon.com/images/I/91oTqmxq9cL.jpg',
              title: 'Naruto'),
        ),
        MangaItem(
          mangaData: MangaData(
              url:
                  'https://images-na.ssl-images-amazon.com/images/I/91oTqmxq9cL.jpg',
              title: 'Naruto'),
        ),
        MangaItem(
          mangaData: MangaData(
              url:
                  'https://images-na.ssl-images-amazon.com/images/I/91oTqmxq9cL.jpg',
              title: 'Naruto'),
        ),
      ],
    );
  }
}
