import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:texttales/components/game/storyblock.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
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
                SizedBox(height: 40,),
                Text("Continue the story!", style: textTalesStyle.copyWith(fontSize: 30),),
                Text("Rounds: 1/4", style: textMedium.copyWith(fontSize: 16),),
                SizedBox(height: 40,),

                StoryBlock()

                SizedBox(height: 20,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}