import 'package:flutter/material.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/gamebg.png'), fit: BoxFit.fill)
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Continue the story!", style: textTalesStyle.copyWith(fontSize: 30),),
                Text("Rounds: 1/4", style: textMedium.copyWith(fontSize: 16),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}