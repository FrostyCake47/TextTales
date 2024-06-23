import 'dart:convert';

import 'package:texttales/models/gamesetting.dart';
import 'package:texttales/models/lobbystatus.dart';
import 'package:texttales/models/player.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketLobbyMessageEncoder{
  final WebSocketChannel channel;
  final GameSetting gameSetting;
  final Player player;
  final LobbyStatus lobbyStatus;
  final int broadcastFlag;
  WebSocketLobbyMessageEncoder({required this.channel, required this.gameSetting, required this.player, required this.lobbyStatus, required this.broadcastFlag}){
    print("broadcasting now");
    //broadcastflag
      // 0 - off
      // 1 - gameSetting broadcast
      // 2 - update readyPlayer

    if(broadcastFlag == 1) gameSettingUpdateBroadcast();
    else if(broadcastFlag == 2) readyPlayerBroadcast();
  }

  
  void gameSettingUpdateBroadcast(){
    channel.sink.add(json.encode({'type':'gameSetting', 'gameSetting':gameSetting.toMap(), 'playerId':player.playerId, 'roomId':lobbyStatus.roomId},));
  }

  void readyPlayerBroadcast(){
    channel.sink.add(jsonEncode({'type':'readyPlayers', 'playerId':player.playerId, 'roomId':lobbyStatus.roomId}));
  }
}