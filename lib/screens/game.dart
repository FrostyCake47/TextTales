import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/components/game/inputblock.dart';
import 'package:texttales/components/game/storyblock.dart';
import 'package:texttales/components/game/submitbutton.dart';
import 'package:texttales/components/game/titleblock.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:texttales/models/gamesetting.dart';
import 'package:texttales/models/player.dart';
import 'package:texttales/models/story.dart';
import 'package:texttales/services/wsdecoder.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GameScreen extends ConsumerStatefulWidget {
  var broadcastFlag = 1;
  var oldsnapshot;
  bool isSubmitted = false;
  GameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  late WebSocketChannel channel;
  late TextEditingController storyController;
  late TextEditingController titleController;
  var message;

  @override
  void initState() {
    super.initState();
    channel = WebSocketChannel.connect(Uri.parse('ws://192.168.18.105:6969'));
    storyController = TextEditingController();
    titleController = TextEditingController();
  }

  @override
  void dispose() {
    channel.sink.close();
    storyController.dispose();
    titleController.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    final _gameData = (ModalRoute.of(context)!.settings.arguments as Map)['gameData'];
    final player = ref.watch(playerProvider);
    final gameData = ref.watch(gameDataProvider);
    


    void onJoinBroadcast(String gameId){
      Map _package = {'type':'joingame', 'player':{'playerId':player.playerId, 'photoURL': player.photoURL, 'name':player.name}, 'gameId':gameId};
      print(_package);
      channel.sink.add(json.encode(_package));
    }

    void titlePageBroadcast(){
      Map _page = {'storyId': gameData.indexOfPlayer(player), 'pageId':gameData.currentRound, 'content':storyController.text, 'playerId':player.playerId};
      Map _story = {'gameId':gameData.gameId, 'storyId': gameData.indexOfPlayer(player), 'title':titleController.text, 'pages': [_page]};
      Map _package = {'type':'titlepage', 'story': _story};

      storyController.text = '';
      titleController.text = '';

      channel.sink.add(json.encode(_package));
    }


    if(widget.broadcastFlag != 0){
      if(widget.broadcastFlag == 1) onJoinBroadcast(_gameData['gameId']);
      else if(widget.broadcastFlag == 2) titlePageBroadcast();

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

                WebSocketMessageDecoder.gameDecoder(ref, message);
              });
            }
            
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 40,),
                    Text(gameData.currentRound == 1 ? "Lets start with your story" : "Continue the story!", style: textTalesStyle.copyWith(fontSize: 30),),
                    Text("Rounds: ${gameData.currentRound}/4", style: textMedium.copyWith(fontSize: 22),),
                    SizedBox(height: 40,),
            
                    
                    
                    
                    (gameData.currentRound == 1) ? 
                    Column(
                      children: [
                        TitleBlock(controller: titleController,),
                        SizedBox(height: 20,),
                        InputBlock(gameData: gameData, controller: storyController,),
                        SizedBox(height: 40,),

                        GestureDetector(
                          onTap: (){
                            if(!widget.isSubmitted){setState(() {
                              widget.broadcastFlag = 2;
                              widget.isSubmitted = !widget.isSubmitted;
                            });
                          }},
                          child: SubmitButton(isSubmitted: widget.isSubmitted)
                        ),
                        Text("Players Submitted: ${gameData.submitCount}/${gameData.currentPlayers.length}", style: textMedium.copyWith(fontSize: 20),),
                      ],
                    ) :

                    Column(
                      children: [
                        StoryBlock(gameData: gameData, player: player,),

                        SizedBox(height: 40,),
                        Text("Write your part", style: textTalesStyle.copyWith(fontSize: 26),),
                        Text("Players Submitted: 2/4", style: textMedium.copyWith(fontSize: 20),),
                        SizedBox(height: 40,),
                
                        InputBlock(gameData: gameData, controller: storyController,),
                      ],
                    ),


                    

                    SizedBox(height: 40,),
                    Text(gameData.toString()), 
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