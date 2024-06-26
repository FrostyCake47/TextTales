import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:texttales/firebase_options.dart';
import 'package:texttales/models/gamedata.dart';
import 'package:texttales/models/gameserver.dart';
import 'package:texttales/models/gamesetting.dart';
import 'package:texttales/models/lobbystatus.dart';

import 'package:texttales/models/player.dart';
import 'package:texttales/models/story.dart';
import 'package:texttales/screens/auth.dart';
import 'package:texttales/screens/game.dart';
import 'package:texttales/screens/history.dart';
import 'package:texttales/screens/home.dart';
import 'package:texttales/screens/lobby.dart';
import 'package:texttales/screens/setting.dart';
import 'package:texttales/screens/story.dart';

final playerProvider = StateNotifierProvider<PlayerNotifier, Player>((ref) => PlayerNotifier(Player('', '', '')));
final toggleJoinGameProvider = StateNotifierProvider<ToggleJoinGameNotifier, ToggleJoinGame>((ref) => ToggleJoinGameNotifier(ToggleJoinGame(true)));
final gameSettingProvider = StateNotifierProvider<GameSettingNotifier, GameSetting>((ref) => GameSettingNotifier(GameSetting('Classic', 5, 200, 60)));
final lobbyStatusProvider = StateNotifierProvider<LobbyStatusNotifier, LobbyStatus>((ref) => LobbyStatusNotifier(LobbyStatus(0, <Player>{}, {}))); 
final gameDataProvider = StateNotifierProvider<GameDataNotifier, GameData>((ref) => GameDataNotifier(GameData(gameId: '', gameSetting: GameSetting('Classic', 5, 200, 60), stories: <Story>[], currentPlayers: <Player>{}, currentRound: 1, newRoundFlag: false, submitCount: 0)));
//final gameServerProvider = StateNotifierProvider<GameServerNotifier, GameServer>((ref) => GameServerNotifier(GameServer(name: 'Jio localhost', ip: 'http://192.168.29.226')));
final gameServerProvider = StateNotifierProvider<GameServerNotifier, GameServer>((ref) => GameServerNotifier(GameServer(name: 'KV localhost', ip: 'http://192.168.18.105')));

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  await Hive.initFlutter();

  var serveripbox = await Hive.openBox('serverip');

  var box = Hive.box('serverip');
  var ip = box.get('ip');
  if(ip == null) box.put('ip', '13.233.167.195');

  runApp(ProviderScope(
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/' : (context) => HomeScreen(),
        '/auth' : (context) => const AuthScreen(),
        '/lobby' : (context) => LobbyScreen(),
        '/game' : (context) => GameScreen(),
        '/story' : (context) => StoryScreen(),
        '/setting' : (context) => const SettingScreen(),
        '/history' : (context) => const HistoryScreen(),
      },
    
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xfff0eff4)) 
        ).apply(
          bodyColor: Colors.white, 
          displayColor: Colors.blue, 
        )
      ),
    ),
  ));
}

