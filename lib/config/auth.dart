import 'package:firebase_auth/firebase_auth.dart';
import 'package:vid_viewr/config/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Criar objeto user apartir de FirebaseUser
  LibUser? _userFromFirebaseUser(User? user) {
    if (user != null) {
      return LibUser(
          uid: user.uid,
          privilege: 0,
          displayName: user.displayName.toString(),
          email: user.email.toString(),
          phoneNumber: user.phoneNumber.toString(),
          photoURL: user.photoURL.toString());
    }
    return null;
  }

  // auth change user stream
  Stream<LibUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
    // .map((User? user) => _userFromFirebaseUser(user));
  }

  // Sign in Anonymously
  Future signInAnon() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      User? user = userCredential.user;
      return _userFromFirebaseUser(user);
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
      return null;
    }
  }

  // Sign in Email & Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User? user = credential.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }
  }

  // Register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = credential.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('A senha fornecida é muito fraca.');
      } else if (e.code == 'email-already-in-use') {
        print('A conta já existe para esse e-mail.');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
  // Sign out

  Future signOut() async {
    try {
      print("Signing out");

      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
