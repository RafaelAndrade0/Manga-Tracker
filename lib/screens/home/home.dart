import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manga_tracker/models/manga.dart';
import 'package:manga_tracker/screens/home/manga_list.dart';
import 'package:manga_tracker/services/auth.dart';
import 'package:manga_tracker/services/database.dart';
import 'package:manga_tracker/shared/scaffold.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  List<MangaData> mangaDataList = [
    MangaData(
      title: 'Bleach',
      description: 'Random Description',
      url: 'https://images-na.ssl-images-amazon.com/images/I/7121YupUoeL.jpg',
      categories: ['Action1', 'Comedy', 'Adventure'],
      favorites: 500,
    ),
    MangaData(
      title: 'One Piece',
      description: 'Random Description',
      url: 'https://images-na.ssl-images-amazon.com/images/I/91veX8sh2IL.jpg',
      categories: ['Action2', 'Comedy', 'Adventure'],
      favorites: 500,
    ),
    MangaData(
      title: 'Naruto',
      description: 'Random Description',
      url: 'https://images-na.ssl-images-amazon.com/images/I/91oTqmxq9cL.jpg',
      categories: ['Action3', 'Comedy', 'Adventure'],
      favorites: 500,
    ),
    MangaData(
      title: 'My Hero Academia',
      description: 'Random Description',
      url:
          'https://vignette.wikia.nocookie.net/bokunoheroacademia/images/6/65/US_Volume_4.png/revision/latest?cb=20180827061523',
      categories: ['Action4', 'Comedy', 'Adventure'],
      favorites: 500,
    )
  ];

  void _onItemTapped(int index) {
    print(DatabaseService().mangasFirebase);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: 'Home',
      actions: <Widget>[
        FlatButton.icon(
          onPressed: () async => await AuthService().signOut(),
          icon: Icon(
            Icons.person_outline,
            color: Colors.white,
          ),
          label: Text(
            'Sign Out',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
      body: ListView(
        children: <Widget>[
          MangaList(
            title: 'Most Favorited',
            mangaDataList: mangaDataList,
          ),
          SizedBox(height: 10.0),
          MangaList(
            title: 'Recently Added',
            mangaDataList: mangaDataList,
          ),
          SizedBox(height: 10.0),
          MangaList(
            title: 'Recommended',
            mangaDataList: mangaDataList,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
