import 'package:firebase_auth/firebase_auth.dart';
import 'package:manga_tracker/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> signInAnon() async {
    try {
      var result = await _auth.signInAnonymously();
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }

  Future<FirebaseUser> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<FirebaseUser> registerWithEmailAndPassword(
      {String email, String password}) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await DatabaseService(uid: result.user.uid).updateUserData(favorites: []);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
