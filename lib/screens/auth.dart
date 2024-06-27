

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:texttales/main.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:texttales/screens/home.dart';
import 'package:texttales/screens/lobby.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String? mode = args['mode'];
    final int? roomId = args['roomId'];
    final WidgetRef? ref = args['ref'];

    if(ref != null) ref.read(gameDataProvider.notifier).clearAll();
    
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(mode == null) return HomeScreen();
          //if(snapshot.hasData) {
          if(snapshot.data?.uid != null) {
            print(mode);
            print("I habe data ${snapshot.data}");
            return LobbyScreen(mode: mode, roomId: roomId);
            }
          else {
            return HomeScreen();
          }
        },
      ),
    );
  }
}