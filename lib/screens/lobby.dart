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
              //online players
              Text("Configure your game", style: textTalesStyle.copyWith(fontSize: 30),),
              Text("only leaders can edit the settings", style: textMedium.copyWith(fontSize: 16),),
              //configs
              /*Column(
                children: <Widget>[
                  ConfigTab(item: 'rounds',),
                  ConfigTab(item: 'maxchar',),
                  ConfigTab(item: 'time',),
                ],
              )*/

              Column(
                children: <Widget>[
                  ConfigTab(title: 'rounds', desc: "amount of turns in the game ",),
                  ConfigTab(title: 'maxChar', desc: "max no of characters per turn ",),
                  ConfigTab(title: 'time', desc: "the time duration of each round ",),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}