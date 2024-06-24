import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:texttales/main.dart';
import 'package:texttales/models/gamesetting.dart';
import 'package:texttales/models/lobbystatus.dart';
import 'dart:convert';

import 'package:texttales/models/player.dart';

class GameRequest{
  Future<int> getRoomId(Player player, WidgetRef ref) async {
    int roomId;
    final gameServer = ref.watch(gameServerProvider);
    Map playerData = {
      'playerId' : player.playerId,
      'name': player.name,
      'photoUrl':player.photoURL
    };

    try{
      print('getRoomID');
      final response = await http.post(
        Uri.parse('${gameServer.ip}:1234/rooms/create'),
        //Uri.parse('http://192.168.89.31:1234/rooms/create'),  // Replace with your IP address
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'playerData':playerData})
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: (){
          return http.Response('Error', 408);
        }
      );

      print('got response');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        roomId = data['roomId'];

      } else {
        // Handle the error
        print('Failed to create room');
        roomId = -1;
        print(response.body);
      }

      print('roomId: $roomId');
      return roomId;
    }
    catch(e){
      print("GameRequest: getGameId error: ${e}");
      roomId = -1;
      return roomId;
    }
  }

  Future<int> getRoomStatus(int roomID, WidgetRef ref) async {
    try{
      final gameServer = ref.watch(gameServerProvider);
      print('getRoomStatus');
      final response = await http.post(
        Uri.parse('${gameServer.ip}:1234/rooms/join'),  // Replace with your IP address
        //Uri.parse('http://192.168.89.31:1234/rooms/join'), 
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'roomId':roomID})
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: (){
          return http.Response('Error', 408);
        }
      );

      print('got response');
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) return 0;
        else return 1;
      } else {
        // Handle the error
        return -1;
      }
    }

    catch(e){
      print("GameRequest: getGameId error: ${e}");
      return -1;
    }
  }

  Future<String> createGame(WidgetRef ref, int? roomId, LobbyStatus lobbyStatus, GameSetting gameSetting) async {
    try{
      final gameServer = ref.watch(gameServerProvider);

      /*var package = Map<String, dynamic>();
      package['roomId'] = roomId ?? 0;
      package['gameSetting'] = gameSetting.toMap();
      package['lobbyStatus'] = lobbyStatus.toMap();
      
      print("package createGame: ${package}");*/

      final response = await http.post(
        Uri.parse('${gameServer.ip}:1234/game/create'),  // Replace with your IP address
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'roomId': roomId})
      ).timeout(
        const Duration(seconds: 10),
        onTimeout: (){
          return http.Response('Error', 408);
        }
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == true) return '0';
        else return '1';

      } else {
        // Handle the error
        return '-1';
      }

    } catch(e){
      print('Create game exception: $e');
      return 'Error';
    }
  }
}