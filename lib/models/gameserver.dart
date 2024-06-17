// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class GameServerNotifier extends StateNotifier<GameServer>{
    GameServerNotifier(super.state);

    void changeServer(String name, String ip){
      state = state.copyWith(name: name, ip: ip);
    }
}

class GameServer {
  String name;
  String ip;

  GameServer({
    required this.name,
    required this.ip,
  });

  GameServer copyWith({
    String? name,
    String? ip,
  }) {
    return GameServer(
      name: name ?? this.name,
      ip: ip ?? this.ip,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'ip': ip,
    };
  }

  factory GameServer.fromMap(Map<String, dynamic> map) {
    return GameServer(
      name: map['name'] as String,
      ip: map['ip'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GameServer.fromJson(String source) => GameServer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'GameServer(name: $name, ip: $ip)';

  @override
  bool operator ==(covariant GameServer other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.ip == ip;
  }

  @override
  int get hashCode => name.hashCode ^ ip.hashCode;
}

