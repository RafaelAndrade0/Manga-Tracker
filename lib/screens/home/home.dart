import 'package:flutter/material.dart';
import 'package:manga_tracker/screens/home/manga_list.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    print('init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        MangaList(
          title: 'Most Favorited',
          // mangaDataList: mangaDataList,
        ),
        SizedBox(height: 10.0),
        MangaList(
          title: 'Recently Added',
          // mangaDataList: mangaDataList,
        ),
        SizedBox(height: 10.0),
        MangaList(
          title: 'Recommended',
          // mangaDataList: mangaDataList,
        ),
      ],
    );
  }
}
