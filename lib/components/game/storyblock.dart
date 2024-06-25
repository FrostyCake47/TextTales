import 'package:flutter/material.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/models/gamedata.dart';
import 'package:texttales/models/player.dart';

class StoryBlock extends StatelessWidget {
  final GameData gameData;
  final Player player;
  final String title = 'Redshire';
  final String content = 'In the heart of the tranquil countryside, where rolling hills met the horizon and the whispers of ancient forests echoed through the valleys, lay a hidden gem known as Redshire. This picturesque village, shrouded in a timeless charm, was a place where every cobblestone street and ivy-clad cottage told a story of its own.';
  const StoryBlock({super.key, required this.gameData, required this.player});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: Color(0xffF2F2F2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color:  Color.fromARGB(64, 0, 0, 0),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          gameData.currentPlayers.length != 0 ? Text(gameData.stories[(gameData.indexOfPlayer(player) + gameData.currentRound -1 )%gameData.currentPlayers.length].title, style: textMedium.copyWith(color: Colors.black, fontWeight: FontWeight.w600),) : Container(),
          SizedBox(height: 10,),
          gameData.currentPlayers.length != 0 ? Text(gameData.stories[(gameData.indexOfPlayer(player) + gameData.currentRound - 1)%gameData.currentPlayers.length].pages.last.content, style: textMedium.copyWith(color: Colors.black, fontSize: 16),) : Container(),
        ],
      )
    );
  }
}