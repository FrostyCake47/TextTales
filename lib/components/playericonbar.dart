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
        padding: EdgeInsets.symmetric(vertical: 20),
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
              borderRadius: BorderRadius.circular(20),
              //gradient: playerCardReady,
              border: Border.all(color: Colors.green, width: 1),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(playerList[index].photoURL),
                ),
                SizedBox(width: 10), // Added spacing between avatar and text
                Expanded(
                  child: Text(
                    playerList[index].name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        }
      )
    );
  }
}