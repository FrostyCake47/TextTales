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
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text('TextTales', style: textTalesStyle,)),

              //online players
              Text("Edit the config", style: textMedium,),
              //configs
              Column(
                children: <Widget>[
                  ConfigTab(),
                ],
              )
            ],
          ),
        ),
      ),
    );



    /*return Scaffold(
      backgroundColor: tertiaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("aa", style: textMedium,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  hintStyle: textMedium.copyWith(color: Colors.grey, fontSize: 15)
                ),
                style: textMedium.copyWith(fontSize: 15),
              ),
            ),
            TextButton(onPressed: (){updateName(nameController.text);}, 
            child: Text("Submit", style: textMedium,)),
          ],
        ),

      ),
    );*/
  }
}