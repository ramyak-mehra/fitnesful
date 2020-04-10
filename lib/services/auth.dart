import 'package:fitnesssful/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnesssful/services/database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/fitness.activity.read',
    'https://www.googleapis.com/auth/fitness.activity.write'
  ]);

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(uid: user.uid, name: user.displayName, email: user.email)
        : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
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

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //sign in with google
  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final AuthResult authResult =
          await _auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;
      await DatabaseService(uid: user.uid)
          .updateUserData(user.displayName, user.email);
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
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future googleSignOut() async {
    try {
      await _googleSignIn.signOut();
      print('signed out');
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
