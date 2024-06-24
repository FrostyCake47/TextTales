import 'package:flutter/material.dart';
import 'package:texttales/models/gamedata.dart';

class InputBlock extends StatelessWidget {
  final GameData gameData;
  final TextEditingController controller;
  const InputBlock({super.key, required this.gameData, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        maxLength: gameData.gameSetting.maxchar,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Enter your story here...',
          hintStyle: TextStyle()
        ),
        style: const TextStyle(
          // You can add styling here if needed
        ),
      )
    );
  }
}