import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/components/configtab.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:texttales/models/gamesetting.dart';

class LobbyScreen extends ConsumerWidget {
  LobbyScreen({super.key, this.mode});
  final String? mode;
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GameSetting gameSetting = ref.watch(gameSettingProvider);

    void updateName(String name){
      ref.read(playerProvider.notifier).updateName(name);
    }

    return Scaffold(
      backgroundColor: dark,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/lobbybg.png'), fit: BoxFit.fill)
        ),
        child: Center(
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
              Text("Room ID : 4769", style: textTalesStyle.copyWith(fontSize: 20))
            ],
          ),
        ),
      ),
    );
  }
}