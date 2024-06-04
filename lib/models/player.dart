// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:riverpod/riverpod.dart';

class Player {
  final String name;

  Player(
    this.name,
  );

  Player copyWith({
    String? name,
  }) {
    return Player(
      name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
      map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Player.fromJson(String source) => Player.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Player(name: $name)';

  @override
  bool operator ==(covariant Player other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

class PlayerNotifier extends StateNotifier<Player>{
  PlayerNotifier(super.state);

  void updateName(String name){
    state = state.copyWith(name: name);
  }
}