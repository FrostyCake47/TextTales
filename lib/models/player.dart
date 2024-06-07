// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:riverpod/riverpod.dart';

class Player {
  final String name;
  final String photoURL;
  final String playerId;

  Player(
    this.name,
    this.photoURL,
    this.playerId,
  );

  Player copyWith({
    String? name,
    String? photoURL,
    String? playerId,
  }) {
    return Player(
      name ?? this.name,
      photoURL ?? this.photoURL,
      playerId ?? this.playerId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'photoURL': photoURL,
      'playerId': playerId,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      map['name'] as String,
      map['photoURL'] as String,
      map['playerId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) => Player.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Player(name: $name, photoURL: $photoURL, playerId: $playerId)';

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.photoURL == photoURL &&
      other.playerId == playerId;
  }

  @override
  int get hashCode => name.hashCode ^ photoURL.hashCode ^ playerId.hashCode;
}

class PlayerNotifier extends StateNotifier<Player>{
  PlayerNotifier(super.state);

  void updateName(String name){
    state = state.copyWith(name: name);
  }

  void updateAll(String playerId, String photoURL, String name){
    state = state.copyWith(playerId: playerId, name: name, photoURL: photoURL);
  }
}