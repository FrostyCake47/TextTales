// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:riverpod/riverpod.dart';

class Player {
  final String name;
  final String photoURL;
  final String userId;

  Player(
    this.name,
    this.photoURL,
    this.userId,
  );

  Player copyWith({
    String? name,
    String? photoURL,
    String? userId,
  }) {
    return Player(
      name ?? this.name,
      photoURL ?? this.photoURL,
      userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'photoURL': photoURL,
      'userId': userId,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      map['name'] as String,
      map['photoURL'] as String,
      map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) => Player.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Player(name: $name, photoURL: $photoURL, userId: $userId)';

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.photoURL == photoURL &&
      other.userId == userId;
  }

  @override
  int get hashCode => name.hashCode ^ photoURL.hashCode ^ userId.hashCode;
}

class PlayerNotifier extends StateNotifier<Player>{
  PlayerNotifier(super.state);

  void updateName(String name){
    state = state.copyWith(name: name);
  }

  void updateAll(String userId, String photoURL, String name){
    state = state.copyWith(userId: userId, name: name, photoURL: photoURL);
  }
}