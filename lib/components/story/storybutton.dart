import 'package:flutter/material.dart';
import 'package:texttales/constants/colors.dart';
import 'package:texttales/constants/textstyles.dart';
import 'package:texttales/models/story.dart';

class StoryButton extends StatelessWidget {
  final Story story;
  const StoryButton({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 10,  horizontal: 30),
      decoration: BoxDecoration(
        gradient: gamebtnGradient,
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
      child: Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Image.network(''),
          //const SizedBox(width: 20,),
          Expanded(child: Text(story.title, style: textMedium.copyWith(fontSize: 18, color: Colors.black), textAlign: TextAlign.center,)),
        ],
      )),
    );
  }
}