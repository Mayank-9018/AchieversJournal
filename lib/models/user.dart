import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn gsi = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await gsi.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    }
  }

  bool isSignedIn() {
    return _auth.currentUser != null;
  }

  void logout() async {
    if (await gsi.isSignedIn() && _auth.currentUser != null) {
      gsi.disconnect();
      _auth.signOut();
    }
  }

  String get userId => _auth.currentUser!.uid;
}
