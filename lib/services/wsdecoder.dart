import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/main.dart';
import 'package:texttales/models/gamesetting.dart';
import 'package:texttales/models/player.dart';
import 'package:texttales/models/story.dart';

class WebSocketMessageDecoder{
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

  static void gameDecoder(WidgetRef ref, dynamic message){
    if(message['type'] == 'otherjoingame'){
      final List<dynamic> playerList = message['players'];
      var currentPlayers = Set<Player>();
      playerList.forEach((element) {
        final player = Player.fromMap(element);
        currentPlayers.add(player);
      });
      ref.read(gameDataProvider.notifier).updatePlayers(currentPlayers);
    }

    else if(message['type'] == 'youjoingame'){
      final gameData = message['gameData'];
      final gameId = gameData['gameId'];
      final GameSetting gameSetting = GameSetting.fromMap(gameData['gameSetting']);
      final int currentRound = gameData['currentRound'];
      final bool newRoundFlag = gameData['newRoundFlag'];
      final int submitCount = gameData['submitCount'];
      //
      final List<Story> stories = ((gameData['stories'] ?? <Story>[]) as List)
      .map((storyMap) => Story.fromMap(storyMap))
      .toList();
      //lets see
      final List<dynamic> playerList = message['players'];
      var currentPlayers = Set<Player>();
      playerList.forEach((element) {
        final player = Player.fromMap(element);
        currentPlayers.add(player);
      });

      ref.read(gameDataProvider.notifier).updateAll(gameId, gameSetting, stories, currentPlayers, currentRound, newRoundFlag, submitCount);
      
    }
    //
    else if(message['type'] == 'submitCount'){
      ref.read(gameDataProvider.notifier).updateSubmitCount(message['submitCount']);
    }

    else if(message['type'] == 'newround'){
      List<Story> stories = (message['stories'] as List)
      .map((storyMap) => Story.fromMap(storyMap))
      .toList();

      ref.read(gameDataProvider.notifier).updateStories(stories);
      ref.read(gameDataProvider.notifier).incrementRound();
      ref.read(gameDataProvider.notifier).updateSubmitCount(message['submitCount']);
    }

  }

  static void storyDecoder(){

  }
}