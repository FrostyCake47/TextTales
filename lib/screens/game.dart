import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/components/game/inputblock.dart';
import 'package:texttales/components/game/storyblock.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GameScreen extends ConsumerStatefulWidget {
  var broadcastFlag = 1;
  var oldsnapshot;
  GameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  late WebSocketChannel channel;
  late TextEditingController controller;
  var message;

  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(Uri.parse('ws://192.168.18.105:6969'));
    controller = TextEditingController();
  }

  @override
  void dispose() {
    channel.sink.close();
    controller.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    final gameData = (ModalRoute.of(context)!.settings.arguments as Map)['gameData'];
    final gameSetting = ref.watch(gameSettingProvider);
    final player = ref.watch(playerProvider);
    final lobbyStatus = ref.watch(lobbyStatusProvider);
    final gameServer = ref.watch(gameServerProvider);


    void onJoinBroadcast(String gameId){
      Map _package = {'type':'joingame', 'player':{'playerId':player.playerId, 'photoURL': player.photoURL, 'name':player.name}, 'gameId':gameId};
      print(_package);
      channel.sink.add(json.encode(_package));
    }


    if(widget.broadcastFlag != 0){
      if(widget.broadcastFlag == 1) onJoinBroadcast(gameData['gameId']);

      setState(() {
        widget.broadcastFlag = 0;
      });
    }
    

    return Scaffold(
      backgroundColor: dark,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/gamebg.png'), fit: BoxFit.fill)
        ),
        child: StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            if(snapshot.hasData && (snapshot.data != widget.oldsnapshot)){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                message = jsonDecode(snapshot.data as String);
                print(message);
                widget.oldsnapshot = snapshot.data;

              });
            }
            
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 40,),
                    Text("Continue the story!", style: textTalesStyle.copyWith(fontSize: 30),),
                    Text("Rounds: 1/4", style: textMedium.copyWith(fontSize: 22),),
                    SizedBox(height: 40,),
            
                    StoryBlock(),
            
                    SizedBox(height: 40,),
                    Text("Write your part", style: textTalesStyle.copyWith(fontSize: 26),),
                    Text("Players Submitted: 2/4", style: textMedium.copyWith(fontSize: 20),),
                    SizedBox(height: 40,),
            
                    InputBlock(),

                    SizedBox(height: 40,),
                    Text(snapshot.hasData ? '${snapshot.data}' : '', style: TextStyle(color: Color.fromARGB(255, 68, 39, 0)),),
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