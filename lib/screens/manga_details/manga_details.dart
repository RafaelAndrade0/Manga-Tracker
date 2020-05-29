import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:manga_tracker/models/manga.dart';
import 'package:manga_tracker/screens/authenticate/login.dart';
import 'package:manga_tracker/screens/manga_details/characters.dart';
import 'package:manga_tracker/screens/manga_details/dialog_status.dart';
import 'package:manga_tracker/screens/manga_details/header.dart';
import 'package:manga_tracker/services/auth.dart';
import 'package:manga_tracker/shared/scaffold.dart';

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

  String favoriteMessage() {
    return isFavorite ? 'Favorite' : "Add to favorites";
  }

  @override
  void initState() {
    if (widget.mangaDetails.description.length > 200) {
      firstHalfDescription = widget.mangaDetails.description.substring(0, 200);
      print(firstHalfDescription);
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
    _showStatusMangaDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return DialogStatus();
          });
    }

    return StreamBuilder<FirebaseUser>(
        stream: AuthService().user,
        builder: (context, snapshot) {
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
                            OutlineButton.icon(
                              onPressed: () {
                                if (snapshot.data == null) {
                                  final snackBar = SnackBar(
                                    content: Text('You need to be logged in!'),
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
                                  Scaffold.of(context).showSnackBar(snackBar);
                                  print('Sem usuario logado');
                                } else {
                                  print('Usuario Logado!');
                                  setState(() => isFavorite = !isFavorite);
                                }
                              },
                              icon: isFavorite
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : Icon(Icons.favorite_border),
                              label: Text(
                                favoriteMessage(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
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
