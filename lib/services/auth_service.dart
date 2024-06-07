import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:texttales/models/player.dart';

class AuthService{
  signInWithGoogle() async {
    try{
      print("inside signInWithGoogle function");
      final GoogleSignInAccount? gUser = await GoogleSignIn(scopes: <String>["email"]).signIn();

      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      print("signed in on google");
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credentials);
      return userCredential.user;
    }
    catch(e){
      print("Error at signInWithGoogle(): $e");
    }
  }

  void signOut() async {
    try{
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    }
    catch(e){
      print("Error while signout: $e");
    }
  }
  
}

class PlayerUpdation{
  void addAuthUser(WidgetRef ref, StateNotifierProvider<PlayerNotifier, Player> playerProvider) async {
    try{
      User? user = await AuthService().signInWithGoogle();

      String name = user!.displayName ?? '';
      String photoURL = user.photoURL ?? '';
      String playerId = user.uid ?? '';

      ref.read(playerProvider.notifier).updateAll(playerId, photoURL, name);
      print("Player name: ${name}");
    }
    catch(e){
      print(e);
    }
  }

  void removeAuthUser(WidgetRef ref, StateNotifierProvider<PlayerNotifier, Player> playerProvider) async {
    ref.read(playerProvider.notifier).updateAll('', '', '');
    AuthService().signOut();
  }
}