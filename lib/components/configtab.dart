import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:texttales/models/gamesetting.dart';

class ConfigTab extends ConsumerWidget {
  const ConfigTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final GameSetting gameSetting = ref.watch(gameSettingProvider);
  
  return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: (){
            ref.watch(gameSettingProvider.notifier).updateRounds(gameSetting.rounds - 1);
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
          child: Text("Rounds: ${gameSetting.rounds}", style: textMedium,)
        ),

        GestureDetector(
          onTap: (){
            ref.watch(gameSettingProvider.notifier).updateRounds(gameSetting.rounds + 1);
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