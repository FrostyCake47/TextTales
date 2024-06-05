import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:texttales/models/player.dart';

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

class PlayerUpdation{
  void addAuthenticatedUser(WidgetRef ref, StateNotifierProvider<PlayerNotifier, Player> playerProvider) async {
    try{
      User? user = await AuthService().signInWithGoogle();
      String name = user!.displayName ?? '';
      ref.read(playerProvider.notifier).updateName(name);
      print("Player name: ${name}");
    }
    catch(e){
      print(e);
    }
  }
}