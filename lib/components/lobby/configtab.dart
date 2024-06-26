// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/main.dart';
import 'package:texttales/models/gamesetting.dart';


class ConfigTab extends ConsumerStatefulWidget {
  final String title;
  final String desc;
  final Function(int mode) toggleBroadcastFlag;
  final String mode;

  ConfigTab({super.key, required this.title, required this.desc,  required this.toggleBroadcastFlag, required this.mode});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConfigTabState();
}

class _ConfigTabState extends ConsumerState<ConfigTab> {

  @override
  Widget build(BuildContext context) {
    final gameSetting = ref.watch(gameSettingProvider);
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
    int setting = 0;

    final Map<String, void Function()> decrementActions = {
      'rounds': () {if (gameSetting.rounds > 0 && gameSetting.rounds <= 10) {ref.read(gameSettingProvider.notifier).updateRounds(gameSetting.rounds - 1); widget.toggleBroadcastFlag(1);}},
      'time': () {if (gameSetting.time > 20 && gameSetting.time <= 120) {ref.read(gameSettingProvider.notifier).updateTime(gameSetting.time - 10); widget.toggleBroadcastFlag(1);}},
      'max char': () {if (gameSetting.maxchar > 0 && gameSetting.maxchar <= 210) {ref.read(gameSettingProvider.notifier).updateMaxChar(gameSetting.maxchar - 10); widget.toggleBroadcastFlag(1);}},
      'game mode' : (){}
    };

    final Map<String, void Function()> incrementActions = {
      'rounds': () {if (gameSetting.rounds >= 0 && gameSetting.rounds < 10){ref.read(gameSettingProvider.notifier).updateRounds(gameSetting.rounds + 1); widget.toggleBroadcastFlag(1); }},
      'time': () {if (gameSetting.time >= 20 && gameSetting.time < 120){ref.read(gameSettingProvider.notifier).updateTime(gameSetting.time + 10); widget.toggleBroadcastFlag(1);}},
      'max char': () {if (gameSetting.maxchar >= 0 && gameSetting.maxchar < 210){ref.read(gameSettingProvider.notifier).updateMaxChar(gameSetting.maxchar + 10); widget.toggleBroadcastFlag(1);}},
      'game mode' : (){}
    };

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.only(left:12, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: configCardOuterGradient,
        boxShadow: const [
            BoxShadow(
              color:  Color.fromARGB(64, 0, 0, 0),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(0, 6), // changes position of shadow
            ),
          ],
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: textMedium.copyWith(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                  Text(widget.desc, style: textMedium.copyWith(color: Colors.black, fontSize: 12),)
                ],
              ),
            ),
            //nru
            Container(
              width: 140,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: configCardInnerGradient,
                boxShadow: const [
                  BoxShadow(
                    color:  Color.fromARGB(64, 0, 0, 0),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: widget.title == 'game mode' ? 
                [
                  Text("Classic", style: textMedium.copyWith(color: Colors.white, fontSize: 20),)
                
                ]  

                : [
                   widget.mode == 'create' ? GestureDetector(
                    onTap: (){
                      decrementActions[widget.title]!();
                    },
                    child: Icon(Icons.remove),
                  ) : Container(),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text("${widget.title == 'rounds' ? gameSetting.rounds : widget.title == 'time' ? gameSetting.time : gameSetting.maxchar}", style: textMedium,),
                  ),

                  widget.mode == 'create' ? GestureDetector(
                    onTap: () {
                      incrementActions[widget.title]!();
                    },
                    child: Icon(Icons.add),
                  ) : Container(),
                ],
              ),
            )
          ],
        ),
    );
  }
}