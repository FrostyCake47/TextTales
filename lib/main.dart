import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/firebase_options.dart';

import 'package:texttales/models/player.dart';
import 'package:texttales/screens/auth.dart';
import 'package:texttales/screens/game.dart';
import 'package:texttales/screens/home.dart';
import 'package:texttales/screens/lobby.dart';
import 'package:texttales/screens/story.dart';

final playerProvider = StateNotifierProvider<PlayerNotifier, Player>((ref) => PlayerNotifier(Player('')));
final toggleJoinGameProvider = StateNotifierProvider<ToggleJoinGameNotifier, ToggleJoinGame>((ref) => ToggleJoinGameNotifier(ToggleJoinGame(false)));

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(ProviderScope(
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => HomeScreen(),
        '/auth' : (context) => const AuthScreen(),
        '/lobby' : (context) => LobbyScreen(),
        '/game' : (context) => const GameScreen(),
        '/story' : (context) => const StoryScreen(),
      },
    
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xfff0eff4)) 
        ).apply(
          bodyColor: Colors.orange, 
          displayColor: Colors.blue, 
        )
      ),
    ),
  ));
}

