import 'dart:ui';

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
    return DefaultScaffold(
      title: widget.mangaDetails.title,
      // actions: <Widget>[
      //   IconButton(
      //     icon: isFavorite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
      //     onPressed: () => setState(() => isFavorite = !isFavorite),
      //   ),
      // ],
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 250.0,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(40, 40),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.mangaDetails.url,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(40, 40),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Image.network(
                          widget.mangaDetails.url,
                          height: 200,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                widget.mangaDetails.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30.0,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 2.0,
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Author',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      'Masashi Kishimoto',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Artist',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      'Masashi Kishimoto',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Most Recent Chapter',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      '920',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Status',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      'Completed',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    OutlineButton.icon(
                      onPressed: () {
                        setState(() => isFavorite = !isFavorite);
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
                    IconButton(
                      icon: Icon(Icons.share),
                      tooltip: 'Share',
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.gamepad),
                      tooltip: 'Share',
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 8.0,
                ),
                child: Text(
                  'About',
                  style: TextStyle(
                    fontSize: 16.0,
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
                    setState(() => showMoreDescription = !showMoreDescription);
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
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 80, maxHeight: 100),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: 50.0,
                      backgroundImage: NetworkImage(
                          'https://avatarfiles.alphacoders.com/629/62922.jpg'),
                    ),
                    CircleAvatar(
                      maxRadius: 50.0,
                      backgroundImage: NetworkImage(
                          'https://avatarfiles.alphacoders.com/618/61857.jpg'),
                    ),
                    CircleAvatar(
                      maxRadius: 50.0,
                      backgroundImage: NetworkImage(
                          'https://avatarfiles.alphacoders.com/837/83722.jpg'),
                    ),
                    CircleAvatar(
                      maxRadius: 50.0,
                      backgroundImage: NetworkImage(
                          'https://avatarfiles.alphacoders.com/783/78320.jpg'),
                    ),
                    CircleAvatar(
                      maxRadius: 50.0,
                      backgroundImage: NetworkImage(
                          'https://avatarfiles.alphacoders.com/102/102646.jpg'),
                    ),
                  ],
                ),
              ),
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
    );
  }
}
