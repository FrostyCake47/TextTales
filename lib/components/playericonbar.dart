import 'package:flutter/material.dart';
import 'package:texttales/constants/colors.dart';
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

    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: dark, width: 1)
        ),
        child: ListView.builder(
          itemCount: playerList.length,
          itemBuilder: (context, index){
            return PlayerIcon(player: playerList[index]);
          }),
      ),
    );
  }
}