import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/main.dart';
import 'package:texttales/models/gamesetting.dart';
import 'package:texttales/models/player.dart';

class WebSocketDecoder{
  static void lobbyDecoder(WidgetRef ref, dynamic message){
    if(message['type'] == 'youjoin'){
      final Map _gameSetting = message['gameSetting'];

      //update gamesetting
      ref.read(gameSettingProvider.notifier).updateAll(_gameSetting['gamemode'], _gameSetting['rounds'], _gameSetting['maxchar'], _gameSetting['time']);
      final List<Map<String, dynamic>> _players = (message['players'] as List).cast<Map<String, dynamic>>();

      //update currentPlayers
      _players.forEach((_player){
        ref.read(lobbyStatusProvider.notifier).addPlayer(Player.fromMap(_player));
      });
    }

    //when otherjoins
    else if(message['type'] == 'otherjoin'){
      //update the new player
      Player _player = Player.fromMap(message['player']);
      ref.read(lobbyStatusProvider.notifier).addPlayer(_player);
    }
    
    //when other disconnects
    else if(message['type'] == 'disconnect'){
      //update the disconnected
      final String _playerId = message['playerId'];
      ref.read(lobbyStatusProvider.notifier).removePlayer(_playerId);
    }

    else if(message['type'] == 'gameSetting'){
      final GameSetting _gameSetting = GameSetting.fromMap(message['gameSetting']);
      ref.read(gameSettingProvider.notifier).updateAll(_gameSetting.gamemode, _gameSetting.rounds, _gameSetting.maxchar, _gameSetting.time);
    }

    else if(message['type'] == 'readyPlayers'){
      final List<dynamic> readyPlayerList = jsonDecode(message['readyPlayers']);
      Map<String, bool> readyPlayers = Map();
      readyPlayerList.forEach((item) { 
        readyPlayers[item[0]] = item[1];
      });
      //final Map<String, bool> readyPlayers = (message['readyPlayers'] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as bool));
      ref.read(lobbyStatusProvider.notifier).updateReadyPlayer(readyPlayers);
    }
  }
}