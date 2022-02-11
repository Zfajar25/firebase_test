import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/models/user.dart';
import 'package:firebase_test/services/services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// create new user object based on firebase user
  User? _userFromFirebaseUser(FirebaseUser? user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User?> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser? user) => _userFromFirebaseUser(user));
  }

  // sign with anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign with email password
  Future signInEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email password
  Future registerEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'new member', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
