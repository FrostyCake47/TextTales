import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GameRequest{
  Future<int> getRoomId() async {
    int roomId;
    try{
      print('getRoomID');
      final response = await http.get(
        Uri.parse('http://192.168.18.105:1234/rooms/create'),  // Replace with your IP address
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
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
      roomId = -1;
      return roomId;
    }
  }
}