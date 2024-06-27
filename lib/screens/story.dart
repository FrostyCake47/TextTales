import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:texttales/components/story/goback.dart';
import 'package:texttales/components/story/nextstory.dart';
import 'package:texttales/components/story/selectedstory.dart';
import 'package:texttales/components/story/storybutton.dart';
import 'package:texttales/components/story/titleblock.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:texttales/models/story.dart';
import 'package:texttales/services/wsdecoder.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class StoryScreen extends ConsumerStatefulWidget {
  var broadcastFlag = 1;
  var oldsnapshot;

  StoryScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StoryScreenState();
}

class _StoryScreenState extends ConsumerState<StoryScreen> {
  late FlutterTts flutterTts;
  late WebSocketChannel channel;
  var message;
  late Story? selectedStory = null;
  int displayedStoriesCount = 0;
  Timer? timer;

  void initSpeak() async {
    flutterTts = FlutterTts();
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);

    flutterTts.setVoice({'name': 'en-us-x-sfg#male_2-local', 'locale': 'en-US'});
    /*var voices = await flutterTts.getVoices;
    for (var voice in voices) {
      print(voice);
    }*/
  }

  void speak(String text) async {
    await flutterTts.speak(text);
  }
  
  @override
  void initState() {
    super.initState();
    initSpeak();
    var box = Hive.box('serverip');
    String ip = box.get('ip') ?? '';

    channel = WebSocketChannel.connect(Uri.parse('ws://$ip:6969'));
  }

  @override
  void dispose() {
    channel.sink.close();
    timer?.cancel();
    flutterTts.stop();
    // TODO: implement dispo
    super.dispose();
  }

  
  

  @override
  Widget build(BuildContext context) {
    final data = (ModalRoute.of(context)!.settings.arguments as Map);
    final String? mode =  /*'create';*/ 'join'; /*data['mode'];*/
    final gameData = ref.watch(gameDataProvider);

    void updateSelectedStory(int index){
    setState(() {
      selectedStory = gameData.stories[index];
      });
    }

    void startTimer() {
      timer = Timer.periodic(Duration(seconds: 3), (Timer t) {
        setState(() {
          if (displayedStoriesCount < selectedStory!.pages.length) {
            displayedStoriesCount++;
          } else {
            timer?.cancel();
          }
        });
      });
    }

    return Scaffold(
      backgroundColor: dark,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/storybg.png'), fit: BoxFit.fill)
          ),
        
          child: StreamBuilder(stream: channel.stream, 
          builder: (context, snapshot){
             if(snapshot.hasData && (snapshot.data != widget.oldsnapshot)){
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  message = jsonDecode(snapshot.data as String);
                  print(message);
                  widget.oldsnapshot = snapshot.data;
        
                  //WebSocketMessageDecoder.gameDecoder(ref, message);
                });
              }

              
        
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 40,),
                    Text("Its fun time!", style: textTalesStyle.copyWith(fontSize: 30),),
                    Text("Looks like you’ve all finished your stories", style: textMedium.copyWith(fontSize: 20,), textAlign: TextAlign.center,),
                    SizedBox(height: 40,),
        
                    selectedStory == null ? Column(
                      children: [
                        Text("Select a story to view it", style: textMedium.copyWith(fontSize: 24, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                        (mode == null || mode == 'join') ? Text('Only leader can select the story') : Container(),
                        ListView.builder(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          itemCount: gameData.stories.length,
                          scrollDirection: Axis.vertical,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index){
                            
                            return GestureDetector(
                              onTap: (){
                                if(mode == 'create'){
                                  updateSelectedStory(index);
                                  startTimer();
                                }
                              },
                              child: StoryButton(story: gameData.stories[index]),
                            );
                        }),
                      ],
                    ) :
                    
                    Column(
                      children: [
                        TitleBlock(selectedStory: selectedStory, speak: speak,),
                        SelectedStory(story: selectedStory, players: gameData.currentPlayers.toList(), displayedStoriesCount: displayedStoriesCount, speak: speak,),
                        
                        (mode == 'create' && displayedStoriesCount == selectedStory!.pages.length) ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectedStory = null;
                                    timer?.cancel();
                                    displayedStoriesCount = 0;
                                  });
                                },
                                child: GoBackButton(),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    selectedStory = gameData.stories[(gameData.stories.indexOf(selectedStory ?? Story('', 0, '', [])) + 1) % gameData.stories.length];
                                    timer?.cancel();
                                    displayedStoriesCount = 0;
                                    startTimer();
                                  });
                                },
                                child: NextButton(),
                              ),
                            )
                          ],
                        ) : ((displayedStoriesCount == selectedStory!.pages.length) ? Text('Waiting for leader to select...') : Container()),
                      ],
                    ),
        
                    Text(mode ?? ''),
                    Text(gameData.toString())
                ],
              );
          }),
        ),
      ),
    );
  }
}