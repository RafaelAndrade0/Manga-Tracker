import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:manga_tracker/models/manga.dart';
import 'package:manga_tracker/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference mangaCollection =
      Firestore.instance.collection('mangas');
  final CollectionReference userCollection =
      Firestore.instance.collection('users');
  List<String> favorites = [];

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

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    this.favorites = List.from(snapshot.data['favorites']);
    return UserData(
      uid: snapshot.documentID,
      favoriteMangas: List.from(snapshot.data['favorites']),
    );
  }

  bool isFavorite(String id) {
    return favorites.contains(id);
  }

  Stream<UserData> get userData {
    return userCollection
        .document(uid)
        .snapshots()
        .map((snapshot) => _userDataFromSnapshot(snapshot));
  }

  List<MangaData> _mangaListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.documents
        .map(
          (manga) => MangaData(
            id: manga.data['id'] ?? '',
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
