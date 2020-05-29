import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:manga_tracker/models/manga.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference mangaCollection =
      Firestore.instance.collection('mangas');
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Stream<List<MangaData>> get mangas {
    return mangaCollection
        .snapshots()
        .map((event) => _mangaListFromSnapshots(event));
  }

  Future<void> updateUserData({@required List<String> favorites}) async {
    return await userCollection
        .document(uid)
        .setData({'favorites': favorites, 'settings': ''});
  }

  Stream<QuerySnapshot> get mangasFirebase {
    return mangaCollection.snapshots().map((event) => event);
  }

  List<MangaData> _mangaListFromSnapshots(QuerySnapshot snapshot) {
    print(snapshot.documents.last.data['favorites']);
    return snapshot.documents
        .map(
          (manga) => MangaData(
            title: manga.data['title'] ?? '',
            description: manga.data['description'] ?? '',
            url: manga.data['url'] ?? '',
            categories: List.from(manga.data['categories'] ?? []),
            favorites: manga.data['favorites'] ?? 0,
          ),
        )
        .toList();
  }
}
