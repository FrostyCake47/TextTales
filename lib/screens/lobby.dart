import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/components/configtab.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:texttales/models/gamesetting.dart';
import 'package:texttales/models/player.dart';
import 'package:web_socket_channel/web_socket_channel.dart';



class LobbyScreen extends ConsumerStatefulWidget {
  LobbyScreen({super.key, this.mode, this.roomId});
  final String? mode;
  final int? roomId;
  bool isPlayerIdupdated = false;
  bool isRoomIdInitiallyUpdated = false;

  @override
  ConsumerState<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends ConsumerState<LobbyScreen> {
  late WebSocketChannel _channel;
  late TextEditingController _controller;

  @override
  void initState(){
    super.initState();
    print("initstate of lobby");
    _channel = WebSocketChannel.connect(Uri.parse('ws://192.168.29.226:6969'));
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


    void onJoinBroadcast(int roomId){
      Map _package = {'type':'join', 'player':{'playerId':player.playerId, 'photoUrl': player.photoURL, 'name':player.name}, 'roomId':roomId};
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

    if(!widget.isPlayerIdupdated){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.isRoomIdInitiallyUpdated = true;
        ref.read(lobbyStatusProvider.notifier).changeRoomId(widget.roomId); 
      });
    }
    /**/
    

    print(player.playerId);
    if(player.playerId != '' && !widget.isPlayerIdupdated){
      onJoinBroadcast(widget.roomId ?? 0);
      widget.isPlayerIdupdated = true;
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
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //intro
                    Text("Configure your game", style: textTalesStyle.copyWith(fontSize: 30),),
                    Text("only leaders can edit the settings", style: textMedium.copyWith(fontSize: 16),),
                    
                    SizedBox(height: 30,),
                    //configs
                    Column(
                      children: <Widget>[
                        ConfigTab(title: 'game mode', desc: "determines the type of game  ",),
                        ConfigTab(title: 'rounds', desc: "amount of turns in the game ",),
                        ConfigTab(title: 'max char', desc: "max no of characters per turn ",),
                        ConfigTab(title: 'time', desc: "the time duration of each round ",),
                      ],
                    ),
          
                            
                    SizedBox(height: 50,),
                    Text("Joined Players", style: textTalesStyle.copyWith(fontSize: 30),),
                    Text("Room ID : ${lobbyStatus.roomId}", style: textTalesStyle.copyWith(fontSize: 20)),
                
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