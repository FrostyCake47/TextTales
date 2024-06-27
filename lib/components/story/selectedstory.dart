// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/models/player.dart';
import 'package:texttales/models/story.dart';

class SelectedStory extends StatelessWidget {
  final Story? story;
  final List<Player> players;
  final int displayedStoriesCount;
  const SelectedStory({super.key, required this.story, required this.players, required this.displayedStoriesCount});

  @override
  Widget build(BuildContext context) {
    if(story != null) return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        //color: Colors.white
      ),

      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 20),
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        
        itemCount: displayedStoriesCount,
        itemBuilder: (context, index){
          Player player = Player('', '', '');
          String _playerId = story!.pages[index].playerId;

          players.forEach((_player) => {
            if(_player.playerId == _playerId) player = _player
          });

          return Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: EdgeInsets.symmetric(vertical: 10,  horizontal: 10),
            decoration: BoxDecoration(
              gradient: homebtnGradient,
              borderRadius: BorderRadius.circular(15),
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
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network(player.photoURL, scale: 3,)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(player.name, style: textMedium.copyWith(fontSize: 14, color: Colors.grey.shade700, fontWeight: FontWeight.w600),),
                    Text(story!.pages[index].content, style: textMedium.copyWith(fontSize: 14, color: Colors.black),)
                  ],
                )
              ],
            ),
          );
        }),
    );
    else return Container();
  }
}