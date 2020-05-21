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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 250.0,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget.mangaDetails.url,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.7),
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Image.network(widget.mangaDetails.url),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
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
                          Text(
                            'Author',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Artist',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Most Recent Chapter',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Status',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
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
              widget.mangaDetails.description,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              for (var chip in widget.mangaDetails.categories)
                Chip(
                  label: Text(chip),
                ),

              // Chip(
              //   label: Text('Action'),
              // ),
              // Chip(
              //   label: Text('Comedy'),
              // ),
              // Chip(
              //   label: Text('Fantasy'),
              // ),
              // Chip(
              //   label: Text('Shonnen'),
              // )
            ],
          )
        ],
      ),
    );
  }
}
