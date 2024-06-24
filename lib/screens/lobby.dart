import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/components/lobby/configtab.dart';
import 'package:texttales/components/lobby/playericonbar.dart';
import 'package:texttales/components/lobby/readybutton.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:texttales/models/gamesetting.dart';
import 'package:texttales/models/player.dart';
import 'package:texttales/services/gamerequest.dart';
import 'package:texttales/services/wsdecoder.dart';
import 'package:texttales/services/wsencoder.dart';
import 'package:web_socket_channel/web_socket_channel.dart';



class LobbyScreen extends ConsumerStatefulWidget {
  LobbyScreen({super.key, this.mode, this.roomId});
  String? mode;
  final int? roomId;
  bool isPlayerIdupdated = false;
  bool isRoomIdInitiallyUpdated = false;
  int broadcastFlag = 0;
  var oldsnapshot;

  @override
  ConsumerState<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends ConsumerState<LobbyScreen> {
  late WebSocketChannel _channel;
  late TextEditingController _controller;
  var message;

  @override
  void initState(){
    super.initState();
    print("initstate of lobby");
    _channel = WebSocketChannel.connect(Uri.parse('ws://192.168.18.105:6969'));
    //_channel = WebSocketChannel.connect(Uri.parse('ws://192.168.29.226:6969'));
    //_channel = WebSocketChannel.connect(Uri.parse('ws://192.168.89.31:6969'));
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    print("disposeed why here?");
    _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    final gameSetting = ref.watch(gameSettingProvider);
    final player = ref.watch(playerProvider);
    final lobbyStatus = ref.watch(lobbyStatusProvider);
    final gameServer = ref.watch(gameServerProvider);


    void onJoinBroadcast(int roomId){
      Map _package = {'type':'join', 'player':{'playerId':player.playerId, 'photoURL': player.photoURL, 'name':player.name}, 'roomId':roomId};
      print(_package);
      _channel.sink.add(json.encode(_package));
    }
    
    void updateName(String name){
      ref.read(playerProvider.notifier).updateName(name);
    }

    void _sendMessage() {
      if (_controller.text.isNotEmpty) {
        _channel.sink.add(_controller.text);
      }
    }

    void toggleBroadcastFlag(int mode){
        widget.broadcastFlag = mode;
    }


    if(!widget.isPlayerIdupdated){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.isRoomIdInitiallyUpdated = true;

        ref.read(lobbyStatusProvider.notifier).changeRoomId(widget.roomId);

      });
    }
    /**/
    
    if(player.playerId != '' && !widget.isPlayerIdupdated){
      onJoinBroadcast(widget.roomId ?? 0);
      widget.isPlayerIdupdated = true;
    }

    print(widget.broadcastFlag);
    if(widget.broadcastFlag != 0){
      if(message['type'] == 'gamejoin'){
        Navigator.popAndPushNamed(context, '/game', arguments: {'gameData':message['gameData']});
      }

      WebSocketLobbyMessageEncoder(channel: _channel, gameSetting: gameSetting, player: player, lobbyStatus: lobbyStatus, broadcastFlag: widget.broadcastFlag);
      setState(() {
        widget.broadcastFlag = 0;
      });
    }



    return Scaffold(
      backgroundColor: dark,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/lobbybg.png'), fit: BoxFit.fill)
        ),
        child: StreamBuilder(
          stream: _channel.stream,
          builder: (context, snapshot) {
            if(snapshot.hasData && (snapshot.data != widget.oldsnapshot)){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                message = jsonDecode(snapshot.data as String);
                print(message);
                widget.oldsnapshot = snapshot.data;

                WebSocketDecoder.lobbyDecoder(ref, message);
              });
            }

            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //intro
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Configure your game", style: textTalesStyle.copyWith(fontSize: 30),),
                          IconButton(
                            onPressed: (){
                              setState(() {
                                (widget.mode == 'create') ? (widget.mode = 'join') : (widget.mode = 'create');
                              });
                            }, 
                            icon: Icon(Icons.star, color: Colors.yellow,))
                        ],
                      ),
                    ),
                    widget.mode == 'create' ? Container() : Text("only leaders can edit the settings", style: textMedium.copyWith(fontSize: 16),),
                    
                    SizedBox(height: 30,),
                    //configs
                    Column(
                      children: <Widget>[
                        ConfigTab(title: 'game mode', desc: "determines the type of game  ",  toggleBroadcastFlag: toggleBroadcastFlag, mode: widget.mode ?? '',),
                        ConfigTab(title: 'rounds', desc: "amount of turns in the game ", toggleBroadcastFlag: toggleBroadcastFlag, mode: widget.mode ?? ''),
                        ConfigTab(title: 'max char', desc: "max no of characters per turn ", toggleBroadcastFlag: toggleBroadcastFlag, mode: widget.mode ?? ''),
                        ConfigTab(title: 'time', desc: "the time duration of each round ", toggleBroadcastFlag: toggleBroadcastFlag, mode: widget.mode ?? ''),
                      ],
                    ),
          
                            
                    SizedBox(height: 50,),
                    Text("Joined Players", style: textTalesStyle.copyWith(fontSize: 30),),
                    Text("Room ID : ${lobbyStatus.roomId}", style: textTalesStyle.copyWith(fontSize: 20)),

                    lobbyStatus.currentPlayers.length != 0 ? PlayerIconBar(players: lobbyStatus.currentPlayers) : Text('no players'),

                    GestureDetector(
                      onTap: () async {
                         if(widget.mode == 'join'){
                          setState(() {
                            widget.broadcastFlag = 2;
                          });
                         } 
                        else if(widget.mode == 'create'){
                          if(lobbyStatus.currentPlayers.length - 1<= lobbyStatus.readyPlayers.values.where((ready) => ready).length){
                            final data = await GameRequest().createGame(ref, widget.roomId, lobbyStatus, gameSetting);
                            print(data);

                            if(data['type'] == 'gameData'){
                              _channel.sink.add(jsonEncode({'type':'gamejoin', 'gameData':data['gameData'], 'roomId':lobbyStatus.roomId}));
                              Navigator.popAndPushNamed(context, '/game', arguments: {'gameData':data['gameData']});
                            }
                            
                          }
                        }
                      },
                      child: ReadyButton(isReady: lobbyStatus.readyPlayers[player.playerId] ?? false, mode: widget.mode ?? 'join', lobbyStatus: lobbyStatus,),
                    ),

                    Text(lobbyStatus.readyPlayers.toString()),
                    Text(snapshot.hasData ? '${snapshot.data}' : '', style: TextStyle(color: Color.fromARGB(255, 68, 39, 0)),),
                
                    Form(
                      child: TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(labelText: 'Send a message'),
                      ),
                    ),
                
                    GestureDetector(
                      onTap: _sendMessage,
                      child:const Icon(Icons.send),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}