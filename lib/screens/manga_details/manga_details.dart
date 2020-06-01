import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:manga_tracker/models/manga.dart';
import 'package:manga_tracker/models/user.dart';
import 'package:manga_tracker/screens/authenticate/login.dart';
import 'package:manga_tracker/screens/manga_details/characters.dart';
import 'package:manga_tracker/screens/manga_details/dialog_status.dart';
import 'package:manga_tracker/screens/manga_details/header.dart';
import 'package:manga_tracker/services/database.dart';
import 'package:manga_tracker/shared/scaffold.dart';
import 'package:provider/provider.dart';

class MangaDetails extends StatefulWidget {
  final MangaData mangaDetails;
  MangaDetails({@required this.mangaDetails});

  @override
  _MangaDetailsState createState() => _MangaDetailsState();
}

class _MangaDetailsState extends State<MangaDetails> {
  bool isFavorite = false;
  bool showMoreDescription = false;
  String firstHalfDescription = '';
  String secondHalfDescription = '';

  @override
  void initState() {
    if (widget.mangaDetails.description.length > 200) {
      firstHalfDescription = widget.mangaDetails.description.substring(0, 200);
      secondHalfDescription = widget.mangaDetails.description
          .substring(200, widget.mangaDetails.description.length);
    } else {
      firstHalfDescription = '';
      secondHalfDescription = '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    _showStatusMangaDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return DialogStatus();
          });
    }

    bool favorite(List<String> favorites) {
      return favorites?.contains(widget.mangaDetails.id);
    }

    String favoriteMessage(List<String> favorites) {
      return favorite(favorites) ? 'Favorite' : "Add to favorites";
    }

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user?.uid).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData && user != null) {
            return Container(
              color: Colors.grey[200],
              child: SpinKitChasingDots(
                color: Colors.orangeAccent,
                size: 50.0,
              ),
            );
          }

          return DefaultScaffold(
            title: widget.mangaDetails.title,
            body: Builder(
              builder: (context) => ListView(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Header(
                        title: widget.mangaDetails.title,
                        url: widget.mangaDetails.url,
                        showStatusMangaDialog: _showStatusMangaDialog,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.share),
                              tooltip: 'Share',
                              onPressed: () {},
                            ),
                            snapshot.data != null
                                ? OutlineButton.icon(
                                    onPressed: () {
                                      if (snapshot.data.uid == null) {
                                        final snackBar = SnackBar(
                                          content:
                                              Text('You need to be logged in!'),
                                          action: SnackBarAction(
                                            label: 'Login',
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Login(),
                                                ),
                                              );
                                            },
                                          ),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                      } else {
                                        if (favorite(
                                            snapshot.data.favoriteMangas)) {
                                          var newListFavorites =
                                              snapshot.data.favoriteMangas;
                                          newListFavorites
                                              .remove(widget.mangaDetails.id);
                                          DatabaseService(uid: user.uid)
                                              .updateUserData(
                                                  favorites: newListFavorites);
                                        } else {
                                          DatabaseService(uid: user.uid)
                                              .updateUserData(favorites: [
                                            ...snapshot.data.favoriteMangas,
                                            widget.mangaDetails.id
                                          ]);
                                        }
                                      }
                                    },
                                    icon: favorite(snapshot.data.favoriteMangas)
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : Icon(Icons.favorite_border),
                                    label: Text(
                                      // 'Add to Favorites',
                                      favoriteMessage(
                                          snapshot.data.favoriteMangas),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  )
                                : OutlineButton.icon(
                                    onPressed: () {
                                      final snackBar = SnackBar(
                                        content:
                                            Text('You need to be logged in!'),
                                        action: SnackBarAction(
                                          label: 'Login',
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Login(),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                      Scaffold.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    icon: Icon(Icons.favorite_border),
                                    label: Text('Add to favorites'),
                                  ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        child: Text(
                          'About',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        child: Text(
                          showMoreDescription
                              ? '$firstHalfDescription$secondHalfDescription'
                              : '$firstHalfDescription ...',
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                          onPressed: () {
                            setState(() =>
                                showMoreDescription = !showMoreDescription);
                          },
                          child: showMoreDescription
                              ? Text(
                                  'Show less',
                                  style: TextStyle(color: Colors.orange),
                                )
                              : Text(
                                  'Show More',
                                  style: TextStyle(color: Colors.orange),
                                ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 15.0,
                          vertical: 0.0,
                        ),
                        child: Text(
                          'Characters',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Characters(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          for (var chip in widget.mangaDetails.categories)
                            Chip(
                              label: Text(chip),
                            ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
