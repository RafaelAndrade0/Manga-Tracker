import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manga_tracker/screens/authenticate/authenticate.dart';
import 'package:manga_tracker/screens/authenticate/login.dart';
import 'package:manga_tracker/screens/favorites/favorites.dart';
import 'package:manga_tracker/screens/home/home.dart';
import 'package:manga_tracker/screens/search/search.dart';
import 'package:manga_tracker/screens/settings/settings.dart';
import 'package:manga_tracker/services/auth.dart';
import 'package:manga_tracker/shared/scaffold.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> pages = [
    Home(key: PageStorageKey('Home')),
    Search(key: PageStorageKey('Search')),
    Favorites(key: PageStorageKey('Favorites')),
    Settings()
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return DefaultScaffold(
      title: 'Manga Tracker',
      actions: <Widget>[
        user == null
            ? FlatButton.icon(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                ),
                label: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              )
            : FlatButton.icon(
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
      body: PageStorage(
        child: pages[_selectedIndex],
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
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
