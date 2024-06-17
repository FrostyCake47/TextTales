import 'package:flutter/material.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/models/player.dart';

class PlayerIcon extends StatelessWidget {
  final Player player;
  const PlayerIcon({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(player.photoURL, scale: 2),
    );
  }
}

class PlayerIconBar extends StatelessWidget {
  final Set<Player> players;
  const PlayerIconBar({super.key, required this.players});

  @override
  Widget build(BuildContext context) {
    final List<Player> playerList = players.toList();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        //border: Border.all(color: dark, width: 2)
      ),
      child: GridView.builder(
        padding: EdgeInsets.all(0),
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: playerList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.8), 
        itemBuilder: (context, index){
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 5,),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(backgroundImage: NetworkImage(playerList[index].photoURL),),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(playerList[index].name, overflow: TextOverflow.ellipsis, style: textMedium.copyWith(color: Colors.black, fontSize: 18),),
                )
              ],
            ),
          );
        }
      )
    );
  }
}