import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  signInWithGoogle() async {
    print("inside signInWithGoogle function");
    final GoogleSignInAccount? gUser = await GoogleSignIn(scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credentials = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    print("signed in on google");
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credentials);
    return userCredential.user;  }
}