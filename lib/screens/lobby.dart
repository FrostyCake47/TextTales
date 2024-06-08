import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/components/configtab.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:texttales/models/gamesetting.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LobbyScreen extends ConsumerStatefulWidget {
  LobbyScreen({super.key, this.mode});
  final String? mode;

  @override
  ConsumerState<LobbyScreen> createState() => _LobbyScreenState();
}

class _LobbyScreenState extends ConsumerState<LobbyScreen> {
  @override
  Widget build(BuildContext context) {
    final GameSetting gameSetting = ref.watch(gameSettingProvider);

    final wsUrl = Uri.parse('ws://example.com');
    final _channel = WebSocketChannel.connect(Uri.parse('wss://echo.websocket.events'));
    final _controller = TextEditingController();

    
    void updateName(String name){
      ref.read(playerProvider.notifier).updateName(name);
    }

    void _sendMessage() {
      if (_controller.text.isNotEmpty) {
        _channel.sink.add(_controller.text);
      }
    }

    @override
    void dispose() {
      _channel.sink.close();
      _controller.dispose();
      super.dispose();
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
                    Text("Room ID : 4769", style: textTalesStyle.copyWith(fontSize: 20)),
                
                    Text(snapshot.hasData ? '${snapshot.data}' : ''),
                
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