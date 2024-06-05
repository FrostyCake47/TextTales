// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameSettingNotifier extends StateNotifier<GameSetting>{
  GameSettingNotifier(super.state);

  void updateGamemode(String gamemode){
    state = state.copyWith(gamemode: gamemode);
  }

  void updateRounds(int rounds){
    state = state.copyWith(rounds: rounds);
  }

  void updateMaxChar(int maxchar){
    state = state.copyWith(maxchar: maxchar);
  }

  void updateTime(int time){
    state = state.copyWith(time: time);
  }

  void updateAll(String gamemode, int rounds, int maxchar, int time){
    state = state.copyWith(gamemode: gamemode, rounds: rounds, maxchar: maxchar, time: time);
  }
}

class GameSetting {
  final String gamemode;
  final int rounds;
  final int maxchar;
  final int time;

  GameSetting(
    this.gamemode,
    this.rounds,
    this.maxchar,
    this.time,
  );

  GameSetting copyWith({
    String? gamemode,
    int? rounds,
    int? maxchar,
    int? time,
  }) {
    return GameSetting(
      gamemode ?? this.gamemode,
      rounds ?? this.rounds,
      maxchar ?? this.maxchar,
      time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gamemode': gamemode,
      'rounds': rounds,
      'maxchar': maxchar,
      'time': time,
    };
  }

  factory GameSetting.fromMap(Map<String, dynamic> map) {
    return GameSetting(
      map['gamemode'] as String,
      map['rounds'] as int,
      map['maxchar'] as int,
      map['time'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory GameSetting.fromJson(String source) => GameSetting.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GameSetting(gamemode: $gamemode, rounds: $rounds, maxchar: $maxchar, time: $time)';
  }

  @override
  bool operator ==(covariant GameSetting other) {
    if (identical(this, other)) return true;
  
    return 
      other.gamemode == gamemode &&
      other.rounds == rounds &&
      other.maxchar == maxchar &&
      other.time == time;
  }

  @override
  int get hashCode {
    return gamemode.hashCode ^
      rounds.hashCode ^
      maxchar.hashCode ^
      time.hashCode;
  }
}