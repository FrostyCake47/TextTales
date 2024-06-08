// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:texttales/models/gamesetting.dart';

class ConfigCard extends ConsumerWidget {
  final String item;
  ConfigCard({super.key, required this.item});
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final gameSetting = ref.watch(gameSettingProvider);
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  int setting = 0;

  final Map<String, void Function()> decrementActions = {
    'rounds': () {if (gameSetting.rounds > 0 && gameSetting.rounds <= 10) ref.read(gameSettingProvider.notifier).updateRounds(gameSetting.rounds - 1);},
    'time': () {if (gameSetting.time > 20 && gameSetting.time <= 120) ref.read(gameSettingProvider.notifier).updateTime(gameSetting.time - 10);},
    'maxchar': () {if (gameSetting.maxchar > 0 && gameSetting.maxchar <= 210) ref.read(gameSettingProvider.notifier).updateMaxChar(gameSetting.maxchar - 10);},
  };

  final Map<String, void Function()> incrementActions = {
    'rounds': () {if (gameSetting.rounds >= 0 && gameSetting.rounds < 10) ref.read(gameSettingProvider.notifier).updateRounds(gameSetting.rounds + 1);},
    'time': () {if (gameSetting.time >= 20 && gameSetting.time < 120) ref.read(gameSettingProvider.notifier).updateTime(gameSetting.time + 10);},
    'maxchar': () {if (gameSetting.maxchar >= 0 && gameSetting.maxchar < 210) ref.read(gameSettingProvider.notifier).updateMaxChar(gameSetting.maxchar + 10);},
  };

  //decrementActions[item]!()

  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: (){
              print('decrement $item');
              decrementActions[item]!();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: primaryColor
              ),
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
              child: Icon(Icons.remove),
            ),
          ),
    
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor, width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(child: Text("${capitalize(item)}: ${item == 'rounds' ? gameSetting.rounds : item == 'time' ? gameSetting.time : gameSetting.maxchar}", style: textMedium,))
            ),
          ),
    
          GestureDetector(
            onTap: (){
              incrementActions[item]!();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: primaryColor
              ),
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
              child: Icon(Icons.add),
            ),
          )
        ],
      ),
  );
  }
}