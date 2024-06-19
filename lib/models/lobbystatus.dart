// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:texttales/models/player.dart';

class LobbyStatusNotifier extends StateNotifier<LobbyStatus>{
    LobbyStatusNotifier(super.state);
    void changeRoomId(int? roomId){
      state = state.copyWith(roomId: roomId);
    }


    void addPlayer(Player player){
      //final updatedPlayers = Set<Player>.from(state.currentPlayers)..add(player);
      final updatedPlayers = state.currentPlayers..add(player);

      print('updatedPlayers ${updatedPlayers}');
      state = state.copyWith(currentPlayers: updatedPlayers);
      print('state.currentplayers: ${state.currentPlayers}');
    }

    void removePlayer(String playerId){
      final updatedPlayers = Set<Player>.from(state.currentPlayers)
      ..removeWhere((player) => player.playerId == playerId);
      state = state.copyWith(currentPlayers: updatedPlayers);
    }
}


class LobbyStatus {
  final int? roomId;
  final Set<Player> currentPlayers;
  final Map<String, bool> readyPlayers;

  LobbyStatus(
    this.roomId,
    this.currentPlayers,
    this.readyPlayers,
  );

  LobbyStatus copyWith({
    int? roomId,
    Set<Player>? currentPlayers,
    Map<String, bool>? readyPlayers,
  }) {
    return LobbyStatus(
      roomId ?? this.roomId,
      currentPlayers ?? this.currentPlayers,
      readyPlayers ?? this.readyPlayers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'currentPlayers': currentPlayers.map((x) => x.toMap()).toList(),
      'readyPlayers': readyPlayers,
    };
  }

  factory LobbyStatus.fromMap(Map<String, dynamic> map) {
    return LobbyStatus(
      map['roomId'] != null ? map['roomId'] as int : null,
      Set<Player>.from((map['currentPlayers'] as List<int>).map<Player>((x) => Player.fromMap(x as Map<String,dynamic>),),),
      Map<String, bool>.from((map['readyPlayers'] as Map<String, bool>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory LobbyStatus.fromJson(String source) => LobbyStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'LobbyStatus(roomId: $roomId, currentPlayers: $currentPlayers, readyPlayers: $readyPlayers)';

  @override
  bool operator ==(covariant LobbyStatus other) {
    if (identical(this, other)) return true;
  
    return 
      other.roomId == roomId &&
      setEquals(other.currentPlayers, currentPlayers) &&
      mapEquals(other.readyPlayers, readyPlayers);
  }

  @override
  int get hashCode => roomId.hashCode ^ currentPlayers.hashCode ^ readyPlayers.hashCode;
}
