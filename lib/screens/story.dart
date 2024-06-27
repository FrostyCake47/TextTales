import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:texttales/components/story/storybutton.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
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
  late WebSocketChannel channel;
  var message;
  //bruh
  @override
  void initState() {
    super.initState();
    var box = Hive.box('serverip');
    String ip = box.get('ip') ?? '';

    channel = WebSocketChannel.connect(Uri.parse('ws://$ip:6969'));
  }

  @override
  void dispose() {
    channel.sink.close();
    // TODO: implement dispose
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final gameData = ref.watch(gameDataProvider);


    return Scaffold(
      backgroundColor: dark,
      body: Container(
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

                  Text("Select a story to view it", style: textMedium.copyWith(fontSize: 24, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
                  //
                  /*ListView.builder(
                    itemCount: gameData.stories.length,
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return GestureDetector(
                    
                        onTap: (){},
                        child: StoryButton(),
                      );
                  }),*/

                  Text(gameData.toString())
              ],
            );
        }),
      ),
    );
  }
}