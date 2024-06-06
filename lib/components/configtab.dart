// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:texttales/models/gamesetting.dart';

class ConfigTab extends ConsumerWidget {
  final String item;
  ConfigTab({super.key, required this.item});
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final gameSetting = ref.watch(gameSettingProvider);
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  int setting = 0;

  final Map<String, void Function()> decrementActions = {
    'rounds': () => ref.read(gameSettingProvider.notifier).updateRounds(gameSetting.rounds - 1),
    'time': () => ref.read(gameSettingProvider.notifier).updateTime(gameSetting.time - 1),
    'maxchar': () => ref.read(gameSettingProvider.notifier).updateMaxChar(gameSetting.maxchar - 1),
  };

  final Map<String, void Function()> incrementActions = {
    'rounds': () => ref.read(gameSettingProvider.notifier).updateRounds(gameSetting.rounds + 1),
    'time': () => ref.read(gameSettingProvider.notifier).updateTime(gameSetting.time + 1),
    'maxchar': () => ref.read(gameSettingProvider.notifier).updateMaxChar(gameSetting.maxchar + 1),
  };

  return Row(
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

        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: primaryColor, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text("${capitalize(item)}: ${item == 'rounds' ? gameSetting.rounds : item == 'time' ? gameSetting.time : gameSetting.maxchar}", style: textMedium,)
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
    );
  }
}