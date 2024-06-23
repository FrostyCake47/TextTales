import 'package:flutter/material.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/models/lobbystatus.dart';

class ReadyButton extends StatelessWidget {
  final String mode;
  final bool isReady;
  final LobbyStatus lobbyStatus;
  const ReadyButton({super.key, required this.isReady, required this.mode, required this.lobbyStatus});

  @override
  Widget build(BuildContext context) {
    int readyCount = 0;
    lobbyStatus.readyPlayers.forEach((_playerId, state) {
      if(state == true) readyCount++;
    });
    int playerCount = lobbyStatus.currentPlayers.length;

    return Container(
      width: 150,
      height: 45,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: (mode == 'create') ? (playerCount - 1 <= readyCount ? configCardInnerGradient : playerCardNotStart)
         : (isReady ? playerCardNotReady : configCardInnerGradient),
        
        boxShadow: const [
          BoxShadow(
            color:  Color.fromARGB(100, 0, 0, 0),
            spreadRadius: 0,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: mode == 'create' ? (Center(child: Text('Start', style: textMedium.copyWith(color: Colors.white),))) : 
      Center(child: Text(isReady ? 'Not Ready' : 'Ready', style: textMedium.copyWith(color: Colors.white),)),
      
        
    );

  }
}