// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:texttales/models/gamesetting.dart';
import 'package:texttales/models/player.dart';
import 'package:texttales/models/story.dart';

class GameDataNotifier extends StateNotifier<GameData>{
  GameDataNotifier(super.state);

  void updateAll(String gameId, GameSetting gameSetting, List<Story> stories, Set<Player> currentPlayers, int currentRound, bool newRoundFlag, int submitCount){
    print('shhhhhhhhhhhhhit update aaaaaaaaaaaaaaaal');
    state = state.copyWith(gameId: gameId, gameSetting: gameSetting, stories: stories, currentPlayers: currentPlayers, currentRound: currentRound, newRoundFlag: newRoundFlag, submitCount: submitCount);
  }

  void updateWhenYouJoin(String gameId, GameSetting gameSetting, Set<Player> currentPlayers){
    print('shhhhhhhhhhhhhit update specific aaaaaaaaaaaaaaaal');
    state = state.copyWith(gameId: gameId, gameSetting: gameSetting, currentPlayers: currentPlayers);
  }


  void addStory(Story story){
    var newStories = state.stories;
    newStories.add(story);

    state = state.copyWith(stories: newStories);
  }

  void updateStories(List<Story> stories){
    state = state.copyWith(stories: stories);
  }

  void clearAll(){
    print('shhhhhhhhhhhhhit clear aaaaaaaaaaaaaaaal');
    state = state.copyWith(gameId: '', gameSetting: GameSetting('classic', 5, 200, 60), stories: <Story>[], currentPlayers: <Player>{});
  }

  void updatePlayers(Set<Player> players){
    state = state.copyWith(currentPlayers: players);
  }

  void updateSubmitCount(int submitcount){
    state = state.copyWith(submitCount: submitcount);
  }

  void incrementRound(){
    state = state.copyWith(currentRound: state.currentRound+1);
  }
}



class GameData {
  final String gameId;
  final GameSetting gameSetting;
  final List<Story> stories;
  final Set<Player> currentPlayers;
  final int currentRound;
  final bool newRoundFlag;
  final int submitCount;
  
  GameData({
    required this.gameId,
    required this.gameSetting,
    required this.stories,
    required this.currentPlayers,
    required this.currentRound,
    required this.newRoundFlag,
    required this.submitCount,
  });


  int indexOfPlayer(Player player){
    final playerList = currentPlayers.toList();
    return playerList.indexOf(player);
  }

  GameData copyWith({
    String? gameId,
    GameSetting? gameSetting,
    List<Story>? stories,
    Set<Player>? currentPlayers,
    int? currentRound,
    bool? newRoundFlag,
    int? submitCount,
  }) {
    return GameData(
      gameId: gameId ?? this.gameId,
      gameSetting: gameSetting ?? this.gameSetting,
      stories: stories ?? this.stories,
      currentPlayers: currentPlayers ?? this.currentPlayers,
      currentRound: currentRound ?? this.currentRound,
      newRoundFlag: newRoundFlag ?? this.newRoundFlag,
      submitCount: submitCount ?? this.submitCount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gameId': gameId,
      'gameSetting': gameSetting.toMap(),
      'stories': stories.map((x) => x.toMap()).toList(),
      'currentPlayers': currentPlayers.map((x) => x.toMap()).toList(),
      'currentRound': currentRound,
      'newRoundFlag': newRoundFlag,
      'submitCount': submitCount,
    };
  }

  factory GameData.fromMap(Map<String, dynamic> map) {
    return GameData(
      gameId: map['gameId'] as String,
      gameSetting: GameSetting.fromMap(map['gameSetting'] as Map<String,dynamic>),
      stories: List<Story>.from((map['stories'] as List<int>).map<Story>((x) => Story.fromMap(x as Map<String,dynamic>),),),
      currentPlayers: Set<Player>.from((map['currentPlayers'] as List<int>).map<Player>((x) => Player.fromMap(x as Map<String,dynamic>),),),
      currentRound: map['currentRound'] as int,
      newRoundFlag: map['newRoundFlag'] as bool,
      submitCount: map['submitCount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory GameData.fromJson(String source) => GameData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GameData(gameId: $gameId, gameSetting: $gameSetting, stories: $stories, currentPlayers: $currentPlayers, currentRound: $currentRound, newRoundFlag: $newRoundFlag, submitCount: $submitCount)';
  }

  @override
  bool operator ==(covariant GameData other) {
    if (identical(this, other)) return true;
  
    return 
      other.gameId == gameId &&
      other.gameSetting == gameSetting &&
      listEquals(other.stories, stories) &&
      setEquals(other.currentPlayers, currentPlayers) &&
      other.currentRound == currentRound &&
      other.newRoundFlag == newRoundFlag &&
      other.submitCount == submitCount;
  }

  @override
  int get hashCode {
    return gameId.hashCode ^
      gameSetting.hashCode ^
      stories.hashCode ^
      currentPlayers.hashCode ^
      currentRound.hashCode ^
      newRoundFlag.hashCode ^
      submitCount.hashCode;
  }
}
