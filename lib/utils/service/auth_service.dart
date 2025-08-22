import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static User? get currentUser => _auth.currentUser;
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  //sing up account
  static Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  //sing in account
  static Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return null;
    } catch (e) {
      return e.toString();
    }
  }

  //sing out account
  static Future<void> singOut() async {
    try {
      await _auth.signOut();
      // await _auth.currentUser!.delete();
      //   MainApp();
    } catch (e) {
      print('Error $e');
    }
  }
}
