// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:texttales/models/gamesetting.dart';
import 'package:texttales/models/player.dart';
import 'package:texttales/models/story.dart';


class GameDataNotifier extends StateNotifier<GameData>{
  GameDataNotifier(super.state);

  void updateAll(String gameId, GameSetting gameSetting, List<Story> stories, Set<Player> currentPlayers){
    state = state.copyWith(gameId: gameId, gameSetting: gameSetting, stories: stories, currentPlayers: currentPlayers);
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
    state = state.copyWith(gameId: '', gameSetting: GameSetting('classic', 5, 200, 60), stories: <Story>[], currentPlayers: <Player>{});
  }

  
}



class GameData {
  final String gameId;
  final GameSetting gameSetting;
  final List<Story> stories;
  final Set<Player> currentPlayers;
  GameData({
    required this.gameId,
    required this.gameSetting,
    required this.stories,
    required this.currentPlayers,
  });

  GameData copyWith({
    String? gameId,
    GameSetting? gameSetting,
    List<Story>? stories,
    Set<Player>? currentPlayers,
  }) {
    return GameData(
      gameId: gameId ?? this.gameId,
      gameSetting: gameSetting ?? this.gameSetting,
      stories: stories ?? this.stories,
      currentPlayers: currentPlayers ?? this.currentPlayers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gameId': gameId,
      'gameSetting': gameSetting.toMap(),
      'stories': stories.map((x) => x.toMap()).toList(),
      'currentPlayers': currentPlayers.map((x) => x.toMap()).toList(),
    };
  }

  factory GameData.fromMap(Map<String, dynamic> map) {
    return GameData(
      gameId: map['gameId'] as String,
      gameSetting: GameSetting.fromMap(map['gameSetting'] as Map<String,dynamic>),
      stories: List<Story>.from((map['stories'] as List<int>).map<Story>((x) => Story.fromMap(x as Map<String,dynamic>),),),
      currentPlayers: Set<Player>.from((map['currentPlayers'] as List<int>).map<Player>((x) => Player.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory GameData.fromJson(String source) => GameData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GameData(gameId: $gameId, gameSetting: $gameSetting, stories: $stories, currentPlayers: $currentPlayers)';
  }

  @override
  bool operator ==(covariant GameData other) {
    if (identical(this, other)) return true;
  
    return 
      other.gameId == gameId &&
      other.gameSetting == gameSetting &&
      listEquals(other.stories, stories) &&
      setEquals(other.currentPlayers, currentPlayers);
  }

  @override
  int get hashCode {
    return gameId.hashCode ^
      gameSetting.hashCode ^
      stories.hashCode ^
      currentPlayers.hashCode;
  }
}
